//
//  NewsCellHeaderView.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit
import Kingfisher

class NewsCellHeaderView: UIViewWithXib {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    var avatar: URL? {
        willSet { avatarImageView.kf.setImage(with: newValue, options: [.backgroundDecode, .transition(.fade(0.2))]) }
    }
    
    var username: String? {
        willSet { usernameLabel.attributedText = usernameAttriburedString(text: newValue) }
    }
    
    var postDate: Int? {
        willSet { postDateLabel.attributedText = postDateAttriburedString(value: newValue) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureContainerStackView()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    private func configureContainerStackView() {
        containerStackView.enableAutoLayout()
        containerStackView.setConstraints(to: view)
    }
    
    func update(model: NewsTableViewCell.NewsHeaderModel) {
        self.avatar = model.avatar
        self.username = model.username
        self.postDate = model.postDate
    }
    
    public func usernameAttriburedString(text: String?) -> NSAttributedString? {
        guard let text = text else { return nil }
        
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        ])
        
        return attributedString
    }
    
    public func postDateAttriburedString(value: Int?) -> NSAttributedString? {
        guard let value = value else { return nil }
        
        let text = convertDateToString(value: value)
        let attributedString = NSAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.blueGray,
            .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)
        ])
        
        return attributedString
    }
    
    private func convertDateToString(value: Int) -> String {
        
        let timeInterval = TimeInterval(value)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL в HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        var date = dateFormatter.string(from: myDate)
        date.removeAll { $0 == "." }
        
        return date
    }
}
