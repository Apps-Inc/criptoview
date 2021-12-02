//
//  ViewControllerUI.swift
//  criptoview
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 01/12/21.
//

import Foundation
import UIKit

extension ViewController {
    func buildScreen() {
        title = "Cripto Coins"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 1
        let cellSize = view.frame.size.width/3
        layout.itemSize = CGSize(width: cellSize, height: cellSize)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            CriptoCoinCollectionViewCell.self,
            forCellWithReuseIdentifier: CriptoCoinCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CriptoCoinCollectionViewCell.identifier,
            for: indexPath
        ) as? CriptoCoinCollectionViewCell
        else {
            fatalError("cell does not exists")
        }

        let coin = CriptoCoin.allCases[indexPath.row]
        if let image = UIImage(named: coin.rawValue) {
            cell.configureCell(backgroundImage: image)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chart = ChartViewController()

        let coin = CriptoCoin.allCases[indexPath.row]
        chart.coin = coin
        chart.ticker = tickers[coin]

        present(chart, animated: true)
    }
}
