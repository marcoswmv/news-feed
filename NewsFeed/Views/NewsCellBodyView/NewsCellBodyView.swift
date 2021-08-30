//
//  NewsCellBodyView.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 29.08.2021.
//

import UIKit

class NewsCellBodyView: UIView {

    private var textLabel: UILabel!
    var mediaCollectionView: DynamicHeightCollectionView!
    
    var postText: String? {
        willSet { textLabel.attributedText = textAttriburedString(text: newValue) }
    }
    
    var attachments: [Attachment]?
    
    override init(frame: CGRect) {
        textLabel = UILabel()
        mediaCollectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        
        self.addSubview(textLabel)
        self.addSubview(mediaCollectionView)
        
        configureTextLabel()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(model: NewsTableViewCell.NewsBodyModel) {
        self.postText = model.postText
        self.attachments = model.attachments
        
        mediaCollectionView.reloadData()
    }
    
    private func configureTextLabel() {
        
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.numberOfLines = 8
        
        textLabel.enableAutoLayout()
        textLabel.setTopConstraint(to: self, top: 0)
        textLabel.setHorizontalConstraints(to: self, leading: 18, trailing: -18)
        textLabel.setHeightConstraint(greaterThenOrEqualTo: 50, .defaultLow)
    }
    
    private func configureCollectionView() {
        
        mediaCollectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: Consts.mediaCollectionViewCellId)
        mediaCollectionView.frame = self.bounds
        mediaCollectionView.isScrollEnabled = false
        
        mediaCollectionView.backgroundColor = .clear
        
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        
        mediaCollectionView.enableAutoLayout()
        mediaCollectionView.setHorizontalConstraints(to: self)
        mediaCollectionView.setTopConstraint(to: textLabel, bottom: 15, .defaultLow)
        mediaCollectionView.setBottomConstraint(to: self, bottom: 0)
        mediaCollectionView.setHeightConstraint(greaterThenOrEqualTo: 0, .defaultHigh)
    }
    
    public func textAttriburedString(text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular)
        ])
        
        return attributedString
    }
}

// MARK: - Media data source

extension NewsCellBodyView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = Consts.mediaCollectionViewCellId
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let cell = reusableCell as? MediaCollectionViewCell ?? MediaCollectionViewCell()
        
        if let attachments = attachments {
//            if attachments.indices.elementsEqual([indexPath.row]) {
                let atts = attachments[indexPath.row]
                if atts.type == Consts.photo {
                    if let urlString = atts.photo?.sizes.first(where: { $0.type == "r" })?.url {
                        cell.update(content: .photo(urlString))
                    }
                } else if atts.type == Consts.video {
                    // TO-DO: send video url
                }
//            }
        }
        
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let atts = attachments else { return .zero }
        
        if atts.count % 2 != 0 {
            if indexPath.row == 0 {
                return CGSize(width: (self.frame.size.width), height: (self.frame.size.width/2) - 2)
            }
        }
        return CGSize(width: (self.frame.size.width/2) - 2, height: (self.frame.size.width/3) - 3)
    }
}
