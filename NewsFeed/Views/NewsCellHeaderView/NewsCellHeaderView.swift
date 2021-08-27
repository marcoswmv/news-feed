//
//  NewsCellHeaderView.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

class NewsCellHeaderView: UIViewWithXib {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    var avatar: UIImage? {
        willSet { avatarImageView.image = newValue }
    }
    
    var username: String? {
        willSet { usernameLabel.attributedText = usernameAttriburedString(text: newValue) }
    }
    
    var postDate: String? {
        willSet { postDateLabel.attributedText = postDateAttriburedString(text: newValue) }
    }
    
    var postText: String? {
        willSet { postTextLabel.attributedText = textAttriburedString(text: newValue) }
    }
    
    func update(model: NewsTableViewCell.NewsHeaderModel) {
        self.avatar = model.avatar
        self.username = model.username
        self.postDate = model.postDate
        self.postText = model.postText
    }
    
    public func usernameAttriburedString(text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        ])
        
        return attributedString
    }
    
    public func textAttriburedString(text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular)
        ])
        
        return attributedString
    }
    
    public func postDateAttriburedString(text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.blueGray,
            .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)
        ])
        
        return attributedString
    }
}
