//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit
import Combine

class NewsTableViewCell: UITableViewCell {
    
    private var cellHeader: NewsCellHeaderView
    var cellBody: NewsCellBodyView
    private var cellFooter: NewsCellFooterView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellHeader = NewsCellHeaderView()
        self.cellBody = NewsCellBodyView()
        self.cellFooter = NewsCellFooterView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellBody)
        self.contentView.addSubview(cellFooter)
        
        setHeader()
        setBody()
        setFooter()
    }
    
    private func setHeader() {
        cellHeader.enableAutoLayout()
        cellHeader.setTopConstraint(to: contentView, top: 15)
        cellHeader.setHorizontalConstraints(to: contentView, leading: 18, trailing: -18)
        cellHeader.setHeightConstraint(greaterThenOrEqualTo: 40)
    }
    
    private func setBody() {
        cellBody.enableAutoLayout()
        cellBody.setTopConstraint(to: cellHeader, bottom: 15, .defaultHigh)
        cellBody.setHorizontalConstraints(to: contentView)
        cellBody.setBottomConstraint(to: cellFooter, top: -10)
    }
    
    private func setFooter() {
        cellFooter.enableAutoLayout()
        cellFooter.setHorizontalConstraints(to: contentView, leading: 18, trailing: -18)
        cellFooter.setBottomConstraint(to: contentView, bottom: -10)
        cellFooter.setHeightConstraint(height: 26)
    }
    
    func update(content: Content) {
        switch content {
        case .feedPost(let headerModel, let bodyModel, let footerModel):
            self.cellHeader.update(model: headerModel)
            self.cellBody.update(model: bodyModel)
            self.cellFooter.update(model: footerModel)
        }
    }
}

extension NewsTableViewCell {
    struct NewsHeaderModel {
        var avatar: URL?
        var username: String
        var postDate: Int
    }
    
    struct NewsBodyModel {
        var postText: String
        var attachments: [Attachment]?
    }
    
    struct NewsFooterModel {
        var likesCount: Int?
        var commentsCount: Int?
        var repostsCount: Int?
        var viewsCount: Int?
    }
}

extension NewsTableViewCell {
    enum Content {
        case feedPost(_ headerModel: NewsHeaderModel, _ bodyModel: NewsBodyModel, _ footerModel: NewsFooterModel)
    }
}
