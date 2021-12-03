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

        let title = buildTitle()
        let horizontalStack = buildHorizontalStack()
        let img = buildCurencyImage()

        let imgContainer = UIView()
        imgContainer.translatesAutoresizingMaskIntoConstraints = false
        imgContainer.addSubview(img)
        horizontalStack.addArrangedSubview(imgContainer)

        let stackVertical = UIStackView()
        stackVertical.axis = .vertical
        horizontalStack.addArrangedSubview(stackVertical)
        stackVertical.distribution = .fillEqually

        labelBrl = buildCurencyLabel(text: "BRL: \(ticker.price)")
        stackVertical.addArrangedSubview(labelBrl)

        labelUsd = buildCurencyLabel(text: "USD:")
        stackVertical.addArrangedSubview(labelUsd)

        labelEur = buildCurencyLabel(text: "EUR:")
        stackVertical.addArrangedSubview(labelEur)

        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.isUserInteractionEnabled = false

        let data = LineChartData(dataSet: buildLineGraphDataSet())
        lineChart.data = data
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.enabled = false
        lineChart.rightAxis.enabled = false

        view.addSubview(title)
        view.addSubview(horizontalStack)
        view.addSubview(lineChart)

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            title.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStack.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            horizontalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
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
            lineChart.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 10),
            lineChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            lineChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            lineChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        loadAllCurency()
    }

    private func buildTitle() -> UILabel {
        let title = UILabel()
        title.text = coin.rawValue
        title.font = UIFont.boldSystemFont(ofSize: 40)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }

    private func buildHorizontalStack() -> UIStackView {
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

        return stackHorizontal
    }

    private func buildCurencyImage() -> UIImageView {
        let img = UIImageView(image: UIImage(named: coin.rawValue))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }

    private func buildCurencyLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = "\(text)"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }

    private func buildLineGraphDataSet() -> LineChartDataSet {
        let entries: [ChartDataEntry] = sparkline?.data.enumerated().map {
            ChartDataEntry(x: Double($0.offset), y: Double($0.element.value))
        } ?? []

        let dataSet = LineChartDataSet(entries: entries, label: "Valor em BRL nos últimos 30 dias")
        dataSet.colors = [NSUIColor.black]
        dataSet.circleColors = [NSUIColor.blue]
        dataSet.drawValuesEnabled = false

        return dataSet
    }

    private func loadAllCurency() {
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let coin = self?.coin else { return }

            sleep(2)
            if let usdValue = self?.getCurency(coin: coin, curency: .USD) {
                DispatchQueue.main.async {
                    self?.labelUsd.text = "USD: \(usdValue)"
                }
            }

            sleep(2)
            if let eurValue = self?.getCurency(coin: coin, curency: .EUR) {
                DispatchQueue.main.async {
                    self?.labelEur.text = "EUR: \(eurValue)"
                }
            }
        }
    }

    private func getCurency(coin: CriptoCoin, curency: RealCoin) -> Float? {
        if  let tickerForCorency = NomicsAPI.api.ticker(for: [coin], convert: curency),
            let price = tickerForCorency[coin]?.price {

            return price
        } else {
            return nil
        }
    }
}

extension ChartViewController: ChartViewDelegate {
}
