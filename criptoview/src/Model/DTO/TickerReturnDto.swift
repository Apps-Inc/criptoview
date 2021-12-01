import Foundation

struct TickerReturnDto: Decodable {
    let id: String
    let logo_url: String
    let rank: String
    let price: String
    let symbol: String
}
