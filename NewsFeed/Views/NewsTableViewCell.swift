//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    private var cellHeader: NewsCellHeaderView
    private var cellFooter: NewsCellFooterView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellHeader = NewsCellHeaderView()
        self.cellFooter = NewsCellFooterView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        setHeader()
        setFooter()
    }
    
    private func setHeader() {
        self.contentView.addSubview(self.cellHeader)
        
        self.cellHeader.enableAutoLayout()
        self.cellHeader.setTopConstraint(to: self.contentView, top: 15)
        self.cellHeader.setHorizontalConstraints(to: self.contentView, leading: 18, trailing: -18)
    }
    
    private func setFooter() {
        self.cellFooter = NewsCellFooterView()
        self.contentView.addSubview(self.cellFooter)
        
        self.cellFooter.enableAutoLayout()
        self.cellFooter.setTopConstraint(to: self.cellHeader, bottom: 250)
        self.cellFooter.setHorizontalConstraints(to: self.contentView, leading: 18, trailing: -18)
        self.cellFooter.setBottomConstraint(to: self.contentView, bottom: -10)
    }
    
    func update(content: Content) {
        switch content {
        case .news(let config):
            self.cellHeader.update(photo: config.avatar, username: config.username, postDate: config.postDate, postText: config.postText)
            self.cellFooter.update(likesCount: config.stats.likesCount, commentsCount: config.stats.commentsCount, repostsCount: config.stats.repostsCount, viewsCount: config.stats.viewsCount)
        }
    }
}

extension NewsTableViewCell {
    struct NewsConfiguration {
        var avatar: UIImage?
        var username: String
        var postDate: String
        var postText: String
        var stats: Stats
        
        struct Stats {
            var likesCount: Int?
            var commentsCount: Int?
            var repostsCount: Int?
            var viewsCount: Int?
        }
    }
}

extension NewsTableViewCell {
    enum Content {
        case news(_ configuration: NewsConfiguration)
    }
}
