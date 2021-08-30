//
//  NewsDataSource.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit
import Alamofire
import Kingfisher

class NewsDataSource: BaseTableViewDataSource {
    
    private(set) var postsData: NFTypes.PostsList = NFTypes.PostsList()
    private(set) var usersData: NFTypes.UsersList = NFTypes.UsersList()
    private(set) var groupsData: NFTypes.GroupsList = NFTypes.GroupsList()
    
    private(set) var nextPage: String = ""
    
    override func setup() {
        super.setup()
    }
    
    override func reload() {
        onLoading?(true)
        
        fetchPosts()
    }
    
    // MARK: - Helpers
    
    private func fetchPosts(pagination: Bool = false) {
        guard !NetworkService.shared.isPaginating else {
            print("Already fetching data!")
            return
        }
        
        tableView.tableFooterView = configureLoadingSpinner()
        
        NetworkService.shared.getPosts(from: nextPage, with: pagination, at: .newsfeed) { [weak self] (result: Result<ResponseModelContainer, AFError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    
                    self.onLoading?(false)
                    
                    self.postsData.append(contentsOf: result.response.items)
                    self.usersData.append(contentsOf: result.response.profiles)
                    self.groupsData.append(contentsOf: result.response.groups)
                    
                    self.nextPage = result.response.nextFrom
                    
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    private func configureFeedPost(post: Post) -> NewsTableViewCell.Content {
        
        var newsPostAuthorName = ""
        var avatarURL = URL(string: "")
        
        let authorId = post.sourceId
        if authorId < 0 {
            let groupId = authorId * -1
            if let newsPostAuthor = groupsData.first(where: { $0.id == groupId }) {
                newsPostAuthorName = newsPostAuthor.name
                avatarURL = getAuthorAvatarUrlString(newsPostAuthor.photo50)
            }
        } else {
            if let newsPostAuthor = usersData.first(where: { $0.id == authorId }) {
                newsPostAuthorName = newsPostAuthor.firstName + newsPostAuthor.lastName
                avatarURL = getAuthorAvatarUrlString(newsPostAuthor.photo50)
            }
        }
        
        let headerModel = NewsTableViewCell.NewsHeaderModel(avatar: avatarURL, username: newsPostAuthorName, postDate: post.date)
        let bodyModel = NewsTableViewCell.NewsBodyModel(postText: post.text, attachments: post.attachments)
        let footerModel = NewsTableViewCell.NewsFooterModel(likesCount: post.likes.count, commentsCount: post.comments.count, repostsCount: post.reposts.count, viewsCount: post.views?.count)
        
        return .feedPost(headerModel, bodyModel, footerModel)
    }
    
    private func getAuthorAvatarUrlString(_ urlString: String) -> URL? {
        return URL(string: urlString)
    }
    
    private func configureLoadingSpinner() -> UIView {
        
        let parent = UIApplication.topViewController()!
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: parent.view.bounds.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        
        return footerView
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Consts.newsTableViewCellId
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? NewsTableViewCell ?? NewsTableViewCell(style: .default, reuseIdentifier: cellId)
        
        let post = configureFeedPost(post: postsData[indexPath.row])
        
        cell.update(content: post)
        cell.layoutIfNeeded()
        cell.cellBody.mediaCollectionView.reloadData()
        
        return cell
    }
    
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Scroll View delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (tableView.contentOffset.y + tableView.frame.size.height) > tableView.contentSize.height + 100 {
            print("FETCH \(tableView.contentOffset.y + tableView.frame.size.height)  \(tableView.contentSize.height)")
            fetchPosts(pagination: true)
        }
    }
}
