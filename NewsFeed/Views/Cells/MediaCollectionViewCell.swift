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
    
    private var mediaView: UIView!
    
    private var tap: UITapGestureRecognizer = UITapGestureRecognizer()
    private var videoUrlString: String?
    
    override init(frame: CGRect) {
        mediaView = UIView()
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
        contentView.addSubview(mediaView)
        mediaView.frame = contentView.bounds
        
        mediaView.enableAutoLayout()
        mediaView.setConstraints(to: self.contentView)
    }
    
    private func configureImageView(urlString: String) {
        mediaView.removeGestureRecognizer(tap)
        
        let url = URL(string: urlString)
        let imageView = UIImageView(frame: .zero)
        
        mediaView.addSubview(imageView)
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.enableAutoLayout()
        imageView.setConstraints(to: mediaView)
        
        imageView.kf.setImage(with: url, options: [.backgroundDecode, .transition(.fade(0.2))])
    }
    
    private func configureVideoThumbnail(video: Video) {
        if let urlString = video.image?.first(where: { $0.width == 405 && $0.height == 569 })?.url,
           let url = URL(string: urlString),
           let duration =  video.duration {
            videoUrlString = urlString
            
            let thumbnail = VideoThumbnail()
            
            mediaView.addSubview(thumbnail)
            
            thumbnail.update(content: .init(url: url, duration: duration))
            
            thumbnail.clipsToBounds = true
            thumbnail.contentMode = .scaleAspectFill
            thumbnail.enableAutoLayout()
            thumbnail.setConstraints(to: mediaView)
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mediaView.addGestureRecognizer(tap)
    }
    
    func update(content: MediaContent) {
        switch content {
        case .photo(let urlString):
            configureImageView(urlString: urlString)
            
        case .video(let video):
            configureVideoThumbnail(video: video)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        playVideo()
    }
    
    private func playVideo() {
        
        if let videoUrlString = videoUrlString,
           let url = URL(string: videoUrlString),
           let parentVC = UIApplication.topViewController() {
            let player = AVPlayer(url: url)
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            parentVC.present(playerViewController, animated: true) { playerViewController.player?.play() }
        }
    }
}

extension MediaCollectionViewCell {
    enum MediaContent {
        case photo(_ urlString: String)
        case video(_ video: Video)
    }
}
