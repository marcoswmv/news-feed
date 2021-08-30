//
//  NewsCellFooterView.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

class NewsCellFooterView: UIViewWithXib {

    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var repostsCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    var likesCount: Int? {
        willSet { likesCountLabel.attributedText = valueAttriburedString(value: newValue) }
    }
    
    var commentsCount: Int? {
        willSet { commentsCountLabel.attributedText = valueAttriburedString(value: newValue) }
    }
    
    var repostsCount: Int? {
        willSet { repostsCountLabel.attributedText = valueAttriburedString(value: newValue) }
    }
    
    var viewsCount: Int? {
        willSet { viewsCountLabel.attributedText = valueAttriburedString(value: newValue) }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLabels()
    }
    
    private func configureLabels() {
        likesCountLabel.textAlignment = .right
        likesCountLabel.lineHeight = 18
        likesCountLabel.letterSpacing = -0.08
        
        commentsCountLabel.lineHeight = 18
        commentsCountLabel.letterSpacing = -0.08
        
        repostsCountLabel.lineHeight = 18
        repostsCountLabel.letterSpacing = -0.08
        
        viewsCountLabel.lineHeight = 18
        viewsCountLabel.letterSpacing = -0.08
    }
    
    func update(model: NewsTableViewCell.NewsFooterModel) {
        self.likesCount = model.likesCount
        self.commentsCount = model.commentsCount
        self.repostsCount = model.repostsCount
        self.viewsCount = model.viewsCount
    }
    
    public func valueAttriburedString(value: Int?) -> NSAttributedString? {
        guard let value = value else { return nil }
        let text = String(value)
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.blueGray,
            .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)
        ])
        
        return attributedString
    }
}
