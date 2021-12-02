import UIKit

class ViewController: UIViewController {

    let tickers: [CriptoCoin: Ticker] = {
        NomicsAPI.api.tickerAll() ?? [:]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildScreen()
    }
}
