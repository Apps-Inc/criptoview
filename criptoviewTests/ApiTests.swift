@testable import criptoview

import XCTest

class ApiTests: XCTestCase {
    var api: NomicsAPI!

    override func setUp() {
        api = NomicsAPI(key: Environment.nomicsTestsApiKey)
    }

    override func setUpWithError() throws {
        // Because the free plan of the API only allows 1req/s.
        //
        // Random element to avoid patterns.
        sleep(1 + UInt32(Float.random(in: 0.3 ... 1)))
    }

    // MARK: GET /sparkline

    func testApiSparklineForASingleCoin() {
        XCTAssertNotNil(api.sparkline(for: .BTC, convert: .BRL))
    }

    func testApiSparklineForMultipleCoins() {
        XCTAssertNotNil(api.sparkline(for: [.BTC, .ETH], convert: .BRL))
    }

    func testApiSparklineForAllKnownCoins() {
        XCTAssertNotNil(api.sparklineAll(convert: .BRL))
    }

    // MARK: GET /ticker

    func testApiTickerForASingleCoin() {
        XCTAssertNotNil(api.ticker(for: [.DOGE, .XMR], convert: .BRL))
    }

    func testApiTickerForAllCoins() {
        XCTAssertNotNil(api.tickerAll(convert: .BRL))
    }
}
