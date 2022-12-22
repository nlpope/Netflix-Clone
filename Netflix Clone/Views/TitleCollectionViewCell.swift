//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/21/22.
//
//  Responsible for handling everything inside collection view instead of default cell we get

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    //anonymous closure
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: model) else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
