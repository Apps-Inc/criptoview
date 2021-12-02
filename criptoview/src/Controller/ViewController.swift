import UIKit

class ViewController: UIViewController {

    let tickers: [CriptoCoin: Ticker] = {
        NomicsAPI.api.tickerAll(convert: .BRL) ?? [:]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildScreen()
    }
}
