//
//  ChartViewController.swift
//  criptoview
//
//  Created by VICTOR MOREIRA MELLO on 01/12/21.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    var coin: CriptoCoin!
    var ticker: Ticker!
    var lineChart = LineChartView()
    var sparkline: Sparkline?

    var labelBrl: UILabel!
    var labelUsd: UILabel!
    var labelEur: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        sparkline = NomicsAPI.api.sparkline(for: CriptoCoin.withLabel(ticker.id)!, convert: .BRL)
        buildScreen()
    }

    func update() {
        let entries = [
            ChartDataEntry(x: 1, y: 14),
            ChartDataEntry(x: 2, y: 143),
            ChartDataEntry(x: 3, y: 13),
            ChartDataEntry(x: 4, y: 2341),
            ChartDataEntry(x: 5, y: 441)
        ]

        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }
}
