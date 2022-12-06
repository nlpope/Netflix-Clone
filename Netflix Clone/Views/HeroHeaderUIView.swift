//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/6/22.
//

import UIKit

class HeroHeaderUIView: UIView {
    //give it a frame, inside frame assign 3 things:
    //uiimage view
    //two buttons - download and play
    
    private let heroImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
