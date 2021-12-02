import Foundation

enum CriptoCoin: String, CaseIterable {
    case BTC = "Bitcoin"
    case DOGE = "Dogecoin"
    case ETH = "Etherium"
    case XMR = "Monero"

    var symbol: String { String(describing: self) }

    static func withLabel(_ label: String) -> CriptoCoin? {
        self.allCases.first { label == $0.symbol }
    }
}
