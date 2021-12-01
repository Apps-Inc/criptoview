import Foundation

enum CriptoCoin: String, CaseIterable {
    case BTC = "Bitcoin"
    case DOGE = "Dogecoin"
    case ETH = "Etherium"
    case XMR = "Monero"

    static func withLabel(_ label: String) -> CriptoCoin? {
        self.allCases.first { label == String(describing: $0) }
    }
}
