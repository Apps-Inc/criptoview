import Foundation

struct Sparkline {
    let data: [(timestamp: String, value: Float)]

    init(dto: SparklineReturnDto) {
        data = dto.timestamps.enumerated().map { (index, timestamp) in
            (timestamp: timestamp, value: Float(dto.prices[index]) ?? 0)
        }
    }
}
