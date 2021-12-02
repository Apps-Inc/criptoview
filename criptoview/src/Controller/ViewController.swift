import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        let api = NomicsAPI(key: "b91b2ed6c75004f22ab854565929e843b9b8ae38")
        let sparkline = api.sparkline(for: .BTC, convert: .BRL)
        buildScreen()
    }
}
