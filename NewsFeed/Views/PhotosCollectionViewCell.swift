//
//  PhotosCollectionViewCell.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureImageView()
    }
    
    fileprivate func configureImageView() {
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
