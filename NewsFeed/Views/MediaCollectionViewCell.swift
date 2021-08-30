//
//  PhotosCollectionViewCell.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import UIKit
import Kingfisher
import AVKit
import AVFoundation

class MediaCollectionViewCell: UICollectionViewCell {
    
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
        
        imageView.enableAutoLayout()
        imageView.setConstraints(to: self.contentView)
    }
    
    func update(content: MediaContent) {
        switch content {
        case .photo(let urlString):
            
            let url = URL(string: urlString)
            imageView.kf.setImage(with: url, options: [.backgroundDecode, .transition(.fade(0.2))])
            
        case .video(let urlString):
            break
        }
    }
    
    private func playVideo(urlString: String) {
        let parentVC = UIApplication.topViewController()
        let url = URL(string: urlString)!
        let player = AVPlayer(url: url)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        parentVC?.present(playerViewController, animated: true) { playerViewController.player?.play() }
    }
}

extension MediaCollectionViewCell {
    enum MediaContent {
        case photo(_ urlString: String)
        case video(_ urlString: String)
    }
}
