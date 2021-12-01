import Foundation

struct TickerReturnDto: Decodable {
    let id: String
    let logoUrl: String
    let rank: String
    let price: String
    let symbol: String
}
