//
//  NewsDataSource.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation
import UIKit

class NewsDataSource: BaseDataSource {
    
    // network manager
    private(set) var data: NFTypes.NewsList = NFTypes.NewsList()
    
    override func setup() {
        super.setup()
    }
    
    override func reload() {
        
        data = [News(id: 0, fromId: "Marcos Vicente", date: "123445", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam semper mollis purus. Vivamus tempor auctor nunc, non consectetur ipsum condimentum tempus", comments: Comment(count: 10), likes: Like(count: 134), reposts: Repost(count: 203), attachments: nil, views: Views(count: 500), type: "photo"),
                News(id: 0, fromId: "Marcos Vicente", date: "123445", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam semper mollis purus. Vivamus tempor auctor nunc, non consectetur ipsum condimentum tempus", comments: Comment(count: 10), likes: Like(count: 134), reposts: Repost(count: 203), attachments: nil, views: Views(count: 500), type: "photo"),
                News(id: 0, fromId: "Marcos Vicente", date: "123445", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam semper mollis purus. Vivamus tempor auctor nunc, non consectetur ipsum condimentum tempus. Vivamus tempor auctor nunc, non consectetur ipsum condimentum tempus", comments: Comment(count: 10), likes: Like(count: 134), reposts: Repost(count: 203), attachments: nil, views: Views(count: 500), type: "photo"),
                News(id: 0, fromId: "Marcos Vicente", date: "123445", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam semper mollis purus. Vivamus tempor auctor nunc, non consectetur ipsum condimentum tempus", comments: Comment(count: 10), likes: Like(count: 134), reposts: Repost(count: 203), attachments: nil, views: Views(count: 500), type: "photo")]
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Consts.newsTableViewCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? NewsTableViewCell ?? NewsTableViewCell(style: .default, reuseIdentifier: cellId)
        
        let news = data[indexPath.row]
        let headerModel = NewsTableViewCell.NewsHeaderModel(avatar: nil, username: news.fromId, postDate: news.date, postText: news.text)
        let bodyModel = NewsTableViewCell.NewsBodyModel(attachments: news.attachments)
        let footerModel = NewsTableViewCell.NewsFooterModel(likesCount: news.likes.count, commentsCount: news.comments.count, repostsCount: news.reposts.count, viewsCount: news.views.count)
        
        cell.update(content: .news(headerModel, bodyModel, footerModel))
        cell.dummyCollection = [
            UIImage(named: "photo1")!,
            UIImage(named: "photo2")!,
            UIImage(named: "photo3")!,
            UIImage(named: "photo4")!,
            UIImage(named: "photo5")!
        ]
        
        cell.layoutMargins = UIEdgeInsets.zero
        cell.photosCollectionView.reloadData()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
