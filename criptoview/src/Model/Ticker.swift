import Foundation

struct Ticker {
    let id: String
    let logoUrl: URL
    let rank: Int
    let price: Float

    init?(dto: TickerReturnDto) {
        guard let logoUrl = URL(string: dto.logoUrl),
              let rank = Int(dto.rank),
              let price = Float(dto.price)
        else {
            return nil
        }

        id = dto.id
        self.logoUrl = logoUrl
        self.rank = rank
        self.price = price
    }
}
