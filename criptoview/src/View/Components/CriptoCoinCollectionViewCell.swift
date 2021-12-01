//
//  CriptoCoinCollectionViewCell.swift
//  criptoview
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 01/12/21.
//

import UIKit

class CriptoCoinCollectionViewCell: UICollectionViewCell {
    static let identifier = "CriptoCoinCell"
    private let criptoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = criptoImage
        contentView.clipsToBounds = true
    }
    
    func configureCell(backgroundImage : UIImage){
        criptoImage.image = backgroundImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        criptoImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
