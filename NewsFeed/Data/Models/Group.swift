//
//  Groups.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 27.08.2021.
//

import Foundation

struct Group: Codable {
    
    var id: Int
    var name: String
    var photo50: String?
}

//"groups": [{
//"id": 24565142,
//"name": "Клуб National Geographic Россия",
//"screen_name": "natgeoru",
//"is_closed": 0,
//"type": "page",
//"is_admin": 0,
//"is_member": 1,
//"is_advertiser": 0,
//"photo_50": "https://sun9-11.u..._eaor5u9s&ava=1",
//"photo_100": "https://sun9-11.u...ZB_etFEqc&ava=1",
//"photo_200": "https://sun9-11.u...kKH6Qr2So&ava=1"
//}
