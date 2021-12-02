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
        title.text = "Coin"
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

        let img = UIImageView(image: UIImage(systemName: "house"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        stackHorizontal.addArrangedSubview(img)

        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        stackHorizontal.addArrangedSubview(stackVertical)
        stackVertical.distribution = .fillEqually

        let labelBrl = UILabel()
        labelBrl.text = "BRL: 123123"
        labelBrl.font = UIFont.boldSystemFont(ofSize: 20)
        stackVertical.addArrangedSubview(labelBrl)

        let labelUsd = UILabel()
        labelUsd.text = "USD: 123123"
        labelUsd.font = UIFont.boldSystemFont(ofSize: 20)
        stackVertical.addArrangedSubview(labelUsd)

        let labelEur = UILabel()
        labelEur.text = "EUR: 123123"
        labelEur.font = UIFont.boldSystemFont(ofSize: 20)
        stackVertical.addArrangedSubview(labelEur)

        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.isUserInteractionEnabled = false

        let set = LineChartDataSet(entries: [], label: "Value")
        set.colors = [NSUIColor.black]
        set.circleColors = [NSUIColor.blue]
        let data = LineChartData(dataSet: set)
        lineChart.data = data

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
            img.heightAnchor.constraint(equalTo: img.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            lineChart.topAnchor.constraint(equalTo: stackHorizontal.bottomAnchor, constant: 10),
            lineChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            lineChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            lineChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ChartViewController: ChartViewDelegate {
}
