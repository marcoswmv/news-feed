//
//  User.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct User: Codable {
    
    var uid: Int
    var firstName: String
    var lastName: String
    var photo50: String?
}

//"profiles": [{
//"id": 100,
//"first_name": "VK Administration",
//"last_name": "",
//"is_closed": false,
//"can_access_closed": true,
//"is_service": true,
//"sex": 2,
//"screen_name": "id100",
//"photo_50": "https://sun9-55.u...wzBfES0HE&ava=1",
//"photo_100": "https://sun9-55.u...ef2P3L2M8&ava=1",
//"online": 0,
//"online_info": {
//"visible": true,
//"is_online": false,
//"is_mobile": false
//}
//}]
