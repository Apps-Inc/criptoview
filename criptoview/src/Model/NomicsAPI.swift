import Foundation

struct NomicsAPI {
    let key: String

    let baseUrl = "https://api.nomics.com/v1/currencies/"

    init(key: String) {
        self.key = key
    }

    private func get<T>(as type: T.Type, from url: URL) -> T? where T: Decodable {
        var request = URLRequest(url: url)
        var responseData = Data()

        request.httpMethod = "GET"

        // TODO: precisa mesmo fazer por semáforo?
        let sem = DispatchSemaphore(value: 0)
        let requestTask = URLSession.shared.dataTask(with: request) { (data, _, err) in
            defer { sem.signal() }

            if err != nil {
                print("Error: \(err.debugDescription)")
                return
            }

            responseData = data!
        }
        requestTask.resume()
        sem.wait()

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let decodedData = try? decoder.decode(type, from: responseData) else {
            print("Error decoding JSON for type \(type)")

            print("- responseData: \(responseData)")

            let data = String(data: responseData, encoding: .utf8) ?? "no data"
            print("- data: \(data)")

            return nil
        }

        return decodedData
    }
}

// MARK: GET /sparkline

extension NomicsAPI {
    private func sparklineEndpoint(coins: [CriptoCoin], convert toStandardCoin: RealCoin) -> String {
        let sparklineEndpointTemplate = "sparkline?" +
            "key=%@&" +
            "ids=%@&" +
            "start=2021-10-30T00%%3A00%%3A00Z&" +
            "end=2021-11-03T00%%3A00%%3A00Z&" +
            "convert=%@&"

        return baseUrl + String(
            format: sparklineEndpointTemplate,
            self.key,
            coins.map(\.symbol).joined(separator: ","),
            toStandardCoin.symbol
        )
    }

    func sparkline(for coin: CriptoCoin, convert toStandardCoin: RealCoin) -> Sparkline? {
        let endpoint = sparklineEndpoint(coins: [coin], convert: toStandardCoin)
        guard let url = URL(string: endpoint) else { return nil }

        let sparklineDto = get(as: [SparklineReturnDto].self, from: url)
        guard sparklineDto != nil && sparklineDto!.count == 1 else { return nil }

        return sparklineDto!.map { Sparkline(dto: $0) }[0]
    }

    func sparkline(for coins: [CriptoCoin], convert toStandardCoin: RealCoin) -> [CriptoCoin: Sparkline]? {
        let endpoint = sparklineEndpoint(coins: coins, convert: toStandardCoin)
        guard let url = URL(string: endpoint) else { return nil }

        let sparklineDto = get(as: [SparklineReturnDto].self, from: url)
        guard let sparklineDto = sparklineDto else { return nil }

        var dataset = [CriptoCoin: Sparkline]()

        for dto in sparklineDto {
            guard let coin = CriptoCoin.withLabel(dto.currency) else { continue }
            dataset[coin] = Sparkline(dto: dto)
        }

        return dataset
    }

    func sparklineAll(convert toStandardCoin: RealCoin) -> [CriptoCoin: Sparkline]? {
        return sparkline(for: CriptoCoin.allCases, convert: toStandardCoin)
    }
}

// MARK: GET /ticker

extension NomicsAPI {
    private func tickerEndpoint(coins: [CriptoCoin], convert toStandardCoin: RealCoin) -> String {
        let tickerEndpointTemplate = "ticker?" +
            "key=%@&" +
            "ids=%@&" +
            "interval=1d&" +
            "convert=%@&" +
            "per-page=%d&" +
            "page=1&"

        return baseUrl + String(
            format: tickerEndpointTemplate,
            self.key,
            coins.map(\.symbol).joined(separator: ","),
            toStandardCoin.symbol,
            coins.count
        )
    }

    func ticker(for coins: [CriptoCoin], convert toStandardCoin: RealCoin) -> [CriptoCoin: Ticker]? {
        let endpoint = tickerEndpoint(coins: coins, convert: toStandardCoin)

        guard let url = URL(string: endpoint),
              let dtos = get(as: [TickerReturnDto].self, from: url)
        else {
            return nil
        }

        var dataset = [CriptoCoin: Ticker]()

        for tickerDto in dtos {
            guard let coin = CriptoCoin.withLabel(tickerDto.symbol) else { continue }
            dataset[coin] = Ticker(dto: tickerDto)
        }

        return dataset
    }

    func tickerAll(convert toStandardCoin: RealCoin) -> [CriptoCoin: Ticker]? {
        return ticker(for: CriptoCoin.allCases, convert: toStandardCoin)
    }
}
