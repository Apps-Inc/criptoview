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
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 1
        let cellSize = view.frame.size.width/4
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CriptoCoinCollectionViewCell.identifier,
            for: indexPath
        ) as? CriptoCoinCollectionViewCell
        else {
            fatalError("cell does not exists")
        }

        cell.configureCell(backgroundImage: UIImage(systemName: "house")!)
        cell.backgroundColor = .red
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chart = ChartViewController()
        present(chart, animated: true)
    }
}
