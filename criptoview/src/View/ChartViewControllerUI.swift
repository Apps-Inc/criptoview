//
//  Chart\ViewControllerUI.swift
//  criptoview
//
//  Created by VICTOR MOREIRA MELLO on 01/12/21.
//

import UIKit
import Charts

extension ChartViewController {
    func buildScreen() {
        lineChart.delegate = self
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        let title = UILabel()
        title.text = coin.rawValue
        title.font = UIFont.boldSystemFont(ofSize: 40)
        title.translatesAutoresizingMaskIntoConstraints = false

        let stackHorizontal = UIStackView()
        stackHorizontal.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal.layer.cornerRadius = 10
        stackHorizontal.layer.masksToBounds = true
        stackHorizontal.axis = .horizontal
        stackHorizontal.distribution = .fillEqually
        stackHorizontal.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        stackHorizontal.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        stackHorizontal.layer.borderWidth = 2
        stackHorizontal.layer.cornerRadius = 5
        stackHorizontal.layer.masksToBounds = true

        let img = UIImageView(image: UIImage(named: coin.rawValue))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit

        let imgContainer = UIView()
        imgContainer.translatesAutoresizingMaskIntoConstraints = false
        imgContainer.addSubview(img)
        stackHorizontal.addArrangedSubview(imgContainer)

        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        stackHorizontal.addArrangedSubview(stackVertical)
        stackVertical.distribution = .fillEqually

        let labelBrl = UILabel()
        labelBrl.text = "BRL: \(ticker.price)"
        labelBrl.font = UIFont.boldSystemFont(ofSize: 20)
        stackVertical.addArrangedSubview(labelBrl)

//        let labelUsd = UILabel()
//        labelUsd.text = "USD: 123123"
//        labelUsd.font = UIFont.boldSystemFont(ofSize: 20)
//        stackVertical.addArrangedSubview(labelUsd)
//
//        let labelEur = UILabel()
//        labelEur.text = "EUR: 123123"
//        labelEur.font = UIFont.boldSystemFont(ofSize: 20)
//        stackVertical.addArrangedSubview(labelEur)

        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.isUserInteractionEnabled = false

        let data = LineChartData(dataSet: buildLineGraphDataSet())
        lineChart.data = data
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.enabled = false
        lineChart.rightAxis.enabled = false

        view.addSubview(title)
        view.addSubview(stackHorizontal)
        view.addSubview(lineChart)

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            stackHorizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackHorizontal.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            stackHorizontal.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackHorizontal.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            img.leadingAnchor.constraint(equalTo: imgContainer.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            img.trailingAnchor.constraint(equalTo: imgContainer.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            img.topAnchor.constraint(equalTo: imgContainer.safeAreaLayoutGuide.topAnchor, constant: 10),
            img.bottomAnchor.constraint(equalTo: imgContainer.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            imgContainer.heightAnchor.constraint(equalTo: imgContainer.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            lineChart.topAnchor.constraint(equalTo: stackHorizontal.bottomAnchor, constant: 10),
            lineChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            lineChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            lineChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func buildLineGraphDataSet() -> LineChartDataSet {

        let entries: [ChartDataEntry] = sparkline?.data.enumerated().map {
            ChartDataEntry(x: Double($0.offset), y: Double($0.element.value))
        } ?? []

        sparkline?.data.forEach { print($0) }

        let dataSet = LineChartDataSet(entries: entries, label: "Valor últimos 30 dias")
        dataSet.colors = [NSUIColor.black]
        dataSet.circleColors = [NSUIColor.blue]
        dataSet.drawValuesEnabled = false

        return dataSet
    }
}

extension ChartViewController: ChartViewDelegate {
}
