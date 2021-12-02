import Foundation

enum RealCoin: String, CaseIterable {
    case BRL
    case USD
    case EUR

    var symbol: String { String(describing: self) }

    static func withLabel(_ label: String) -> RealCoin? {
        self.allCases.first { label == $0.symbol }
    }
}
