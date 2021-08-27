//
//  NewsDataSource.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit
import Alamofire

class NewsDataSource: BaseDataSource {
    
    private(set) var newsData: NFTypes.NewsList = NFTypes.NewsList()
    private(set) var usersData: NFTypes.UsersList = NFTypes.UsersList()
    private(set) var groupsData: NFTypes.GroupsList = NFTypes.GroupsList()
    
    override func setup() {
        super.setup()
    }
    
    override func reload() {
        onLoading?(true)
        
        NetworkService.shared.getPosts(endpoint: .newsfeed) { [weak self] (result: Result<ResponseModelContainer, AFError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                self.onLoading?(false)
                
                self.newsData = result.response.items
                self.usersData = result.response.profiles
                self.groupsData = result.response.groups
                
                self.tableView.reloadData()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Consts.newsTableViewCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? NewsTableViewCell ?? NewsTableViewCell(style: .default, reuseIdentifier: cellId)
        
        let news = newsData[indexPath.row]
        var newsPostAuthorName = ""
        var avatarURL = URL(string: "")
        
        if let authorId = news.sourceId {
            if authorId < 0 {
                let groupId = authorId * -1
                if let newsPostAuthor = groupsData.first(where: { $0.id == groupId }) {
                    newsPostAuthorName = newsPostAuthor.name
                    if let url = newsPostAuthor.photo50 {
                        avatarURL = URL(string: url)
                    }
                }
            } else {
                if let newsPostAuthor = usersData.first(where: { $0.id == authorId }) {
                    newsPostAuthorName = newsPostAuthor.firstName + newsPostAuthor.lastName
                    if let url = newsPostAuthor.photo50 {
                        avatarURL = URL(string: url)
                    }
                }
            }
        }
        
        let headerModel = NewsTableViewCell.NewsHeaderModel(avatar: avatarURL, username: newsPostAuthorName, postDate: news.date, postText: news.text)
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
