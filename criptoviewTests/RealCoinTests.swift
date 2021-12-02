@testable import criptoview

import XCTest

class RealCoinTests: XCTestCase {
    func testCoinSymbol() {
        XCTAssertEqual("BRL", RealCoin.BRL.symbol)
        XCTAssertEqual("USD", RealCoin.USD.symbol)
        XCTAssertEqual("EUR", RealCoin.EUR.symbol)
    }

    func testConvertingFromLabel() {
        let cases: [(input: String, expected: RealCoin?)] = [
            (input: "BRL", expected: .BRL),
            (input: "USD", expected: .USD),
            (input: "EUR", expected: .EUR)
        ]

        for testCase in cases {
            let got = RealCoin.withLabel(testCase.input)

            XCTAssertNotNil(got)
            XCTAssertEqual(testCase.expected, got)
        }
    }
}
