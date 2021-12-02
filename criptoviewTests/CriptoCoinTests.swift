@testable import criptoview

import XCTest

class CriptoCoinTests: XCTestCase {
    func testCoinSymbol() {
        XCTAssertEqual("ETH", CriptoCoin.ETH.symbol)
        XCTAssertEqual("BTC", CriptoCoin.BTC.symbol)
        XCTAssertEqual("XMR", CriptoCoin.XMR.symbol)
    }

    func testConvertingFromLabel() {
        let cases: [(input: String, expected: CriptoCoin?)] = [
            (input: "BTC", expected: .BTC),
            (input: "ETH", expected: .ETH),
            (input: "XMR", expected: .XMR)
        ]

        for testCase in cases {
            let got = CriptoCoin.withLabel(testCase.input)

            XCTAssertNotNil(got)
            XCTAssertEqual(testCase.expected, got)
        }
    }
}
