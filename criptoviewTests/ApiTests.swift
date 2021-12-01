@testable import criptoview

import XCTest

class ApiTests: XCTestCase {
    var api: NomicsAPI!

    override func setUp() {
        api = NomicsAPI(key: "b91b2ed6c75004f22ab854565929e843b9b8ae38")
    }

    override func setUpWithError() throws {
        // Because the free plan of the API only allows 1req/s.
        //
        // Random element to avoid patterns.
        sleep(1 + UInt32(Float.random(in: 0.3 ... 1)))
    }

    // MARK: GET /sparkline

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

    // MARK: GET /ticker

    func testApiTickerForASingleCoin() {
        XCTAssertNotNil(api.ticker(for: [.DOGE, .XMR]))
    }

    func testApiTickerForAllCoins() {
        XCTAssertNotNil(api.tickerAll())
    }
}
