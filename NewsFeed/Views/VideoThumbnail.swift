//
//  VideoThumbnail.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 30.08.2021.
//

import UIKit
import Kingfisher


class VideoThumbnail: UIView {
    
    struct VideoThumbnailModel {
        var url: URL?
        var duration: Int
    }
    
    private var imageView: UIImageView!
    private var playButton: UIButton!
    private var durationLabel: UILabel!
    
    var image: URL? {
        willSet { imageView.kf.setImage(with: newValue, options: [.backgroundDecode, .transition(.fade(0.2))]) }
    }
    
    var videoDuration: Int? {
        willSet { durationLabel.attributedText = durationAttriburedString(value: newValue) }
    }
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: .zero)
        playButton = UIButton(frame: .zero)
        durationLabel = UILabel(frame: .zero)
        super.init(frame: frame)
        
        addSubview(imageView)
        configureImageView()
        configureButton()
        configureDurationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(content: VideoThumbnailModel) {
        self.image = content.url
        self.videoDuration = content.duration
    }
    
    private func configureImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.enableAutoLayout()
        imageView.setCenterConstraint(to: self)
    }
    
    private func configureButton() {
        
        imageView.addSubview(playButton)
        
        let icon = UIImage(named: "icPlay")!
        playButton.setImage(icon, for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        playButton.enableAutoLayout()
        playButton.setCenterConstraint(to: imageView)
        playButton.setSizeConstraint(width: 56, height: 56)
    }
    
    private func configureDurationLabel() {
        imageView.addSubview(durationLabel)
        
        durationLabel.backgroundColor = .translucentlack
        durationLabel.layer.cornerRadius = 5
        
        durationLabel.enableAutoLayout()
        durationLabel.setTrailingConstraint(to: imageView, trailing: -10)
        durationLabel.setBottomConstraint(to: imageView, bottom: -10)
        durationLabel.setHeightConstraint(height: 26)
        durationLabel.setWidthConstraint(width: 60)
    }
    
    public func durationAttriburedString(value: Int?) -> NSAttributedString? {
        guard let value = value else { return nil }
        
        let (hour, min, sec) = convertSecondsToVideoDuration(seconds: value)
        
        let text = "\(hour):\(min):\(sec)"
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)
        ])
        
        return attributedString
    }
    
    func convertSecondsToVideoDuration(seconds: Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
