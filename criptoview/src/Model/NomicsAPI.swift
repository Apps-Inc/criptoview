import Foundation

struct NomicsAPI {
    let key: String

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
        guard let decodedData = try? decoder.decode(type, from: responseData) else {
            return nil
        }

        return decodedData
    }

    private func sparklineEndpoint(coins: [CriptoCoin]) -> String {
        let baseUrl = "https://api.nomics.com/v1/currencies/"
        let sparklineEndpointTemplate = "sparkline?" +
            "key=%@&" +
            "ids=%@&" +
            "start=2021-10-30T00%%3A00%%3A00Z&" +
            "end=2021-11-03T00%%3A00%%3A00Z"

        let coins = coins.map { String(describing: $0) }.joined(separator: ",")

        return baseUrl + String(
            format: sparklineEndpointTemplate,
            self.key,
            coins
        )
    }

    func sparkline(for coin: CriptoCoin) -> Sparkline? {
        let endpoint = sparklineEndpoint(coins: [coin])
        guard let url = URL(string: endpoint) else { return nil }

        let sparklineDto = get(as: [SparklineReturnDto].self, from: url)
        guard sparklineDto != nil && sparklineDto!.count == 1 else { return nil }

        return sparklineDto!.map { Sparkline(dto: $0) }[0]
    }

    func sparkline(for coins: [CriptoCoin]) -> [CriptoCoin: Sparkline]? {
        let endpoint = sparklineEndpoint(coins: coins)
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

    func sparklineAll() -> [CriptoCoin: Sparkline]? {
        return sparkline(for: CriptoCoin.allCases)
    }
}
