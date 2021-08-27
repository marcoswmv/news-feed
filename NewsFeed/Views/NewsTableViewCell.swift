//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

extension NewsTableViewCell {
    struct NewsHeaderModel {
        var avatar: UIImage?
        var username: String
        var postDate: String
        var postText: String
    }
    
    struct NewsBodyModel {
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
        case news(_ headerModel: NewsHeaderModel, _ bodyModel: NewsBodyModel, _ footerModel: NewsFooterModel)
    }
}

class NewsTableViewCell: UITableViewCell {
    
    var photosCollectionView: DynamicHeightCollectionView
    private var cellHeader: NewsCellHeaderView
    private var cellFooter: NewsCellFooterView
    
    private var bodyModel: NewsBodyModel?
    var dummyCollection: [UIImage]?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellHeader = NewsCellHeaderView()
        self.photosCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: NewsTableViewCell.createLayout())
        self.cellFooter = NewsCellFooterView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViews()
    }
    
    private func configureViews() {
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(photosCollectionView)
        self.contentView.addSubview(cellFooter)
        
        setHeader()
        setPhotosCollectionView()
        setFooter()
    }
    
    private func setHeader() {
        
        self.cellHeader.enableAutoLayout()
        self.cellHeader.setTopConstraint(to: contentView, top: 15)
        self.cellHeader.setHorizontalConstraints(to: contentView, leading: 18, trailing: -18)
    }
    
    private func setFooter() {
        
        self.cellFooter.enableAutoLayout()
        self.cellFooter.setHorizontalConstraints(to: self.contentView, leading: 18, trailing: -18)
        self.cellFooter.setBottomConstraint(to: self.contentView, bottom: -10)
    }
    
    private func setPhotosCollectionView() {
        
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: Consts.photosCollectionViewCellId)
        photosCollectionView.frame = self.contentView.bounds
        photosCollectionView.isScrollEnabled = false
        
        photosCollectionView.backgroundColor = .clear
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        photosCollectionView.enableAutoLayout()
        photosCollectionView.setHorizontalConstraints(to: self.contentView)
        photosCollectionView.setTopConstraint(to: cellHeader, bottom: 15)
        photosCollectionView.setBottomConstraint(to: cellFooter, top: -10)
        photosCollectionView.setHeightConstraint(height: 480)
        
        photosCollectionView.reloadData()
    }
    
    func update(content: Content) {
        switch content {
        case .news(let headerModel, let bodyModel, let footerModel):
            self.cellHeader.update(model: headerModel)
            self.cellFooter.update(model: footerModel)
            self.bodyModel = bodyModel
        }
    }
}

extension NewsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let inset: CGFloat = 4
        // Large item on top
        let topItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16))
        let topItem = NSCollectionLayoutItem(layoutSize: topItemSize)
        topItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Bottom item
        let bottomItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let bottomItem = NSCollectionLayoutItem(layoutSize: bottomItemSize)
        bottomItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group for bottom item, it repeats the bottom item twice
        let bottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let bottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bottomGroupSize, subitem: bottomItem, count: 2)
        
        // Combine the top item and bottom group
        let fullGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(9/16 + 0.5))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: fullGroupSize, subitems: [topItem, bottomGroup])
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bodyModel?.attachments?.count ?? 0
        dummyCollection?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = Consts.photosCollectionViewCellId
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let cell = reusableCell as? PhotosCollectionViewCell ?? PhotosCollectionViewCell()
        
        cell.imageView.image = dummyCollection?[indexPath.row]
        cell.layoutIfNeeded()
        cell.updateConstraints()
        cell.layoutSubviews()
        return cell
    }
    
}

class DynamicHeightCollectionView: UICollectionView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
