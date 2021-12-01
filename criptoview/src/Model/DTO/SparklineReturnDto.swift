import Foundation

struct SparklineReturnDto: Decodable {
    let currency: String
    let timestamps: [String]
    let prices: [String]
}
