@testable import criptoview

import XCTest

class apiTests: XCTestCase {
    var api: NomicsAPI!

    override func setUp() {
        api = NomicsAPI(key: "b91b2ed6c75004f22ab854565929e843b9b8ae38")
    }

    func testApiSparklineForASingleCoin() {
        XCTAssertNotNil(api.sparkline(for: .BTC))
    }

    func testApiSparklineForMultipleCoins() {
        XCTAssertNotNil(api.sparkline(for: [.BTC]))
        XCTAssertNotNil(api.sparkline(for: [.BTC, .ETH]))
    }

    func testApiSparklineForAllKnownCoins() {
        XCTAssertNotNil(api.sparklineAll())
    }
}
