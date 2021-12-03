import Foundation

enum CriptoCoin: String, CaseIterable {
    case BTC = "Bitcoin"
    case ETH = "Etherium"
    case BNB = "Binance Coin"
    case USDT = "Tether"
    case XMR = "Monero"
    case XRP = "XRP"
    case USDC = "USD Coin"
    case DOT = "Polkadot"
    case DOGE = "Dogecoin"
    case AVAX = "Avalanche"
    case LTC = "Litecoin"
    case TRON = "TRON"
    case DAI = "Dai"
    case XLM = "Stellar"

    var symbol: String { String(describing: self) }

    static func withLabel(_ label: String) -> CriptoCoin? {
        self.allCases.first { label == $0.symbol }
    }
}
