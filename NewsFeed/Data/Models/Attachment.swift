//
//  Attachment.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import Foundation

struct Attachment: Codable {
    var type: String // type: photo or video
    var photo: Avatar?
    var video: Video?
}

//"attachments": [{
//"type": "photo",
//"photo": {
//"album_id": -51,
//"date": 1629797154,
//"id": 457261271,
//"owner_id": -49131654,
//"has_tags": false,
//"access_key": "d387a65a733e239838",
//"post_id": 200318,
//"sizes": [{
//"height": 81,
//"url": "https://sun9-53.u...Z3nk&type=album",
//"type": "m",
//"width": 130
//}, {
//"height": 87,
//"url": "https://sun9-53.u...KiWQ&type=album",
//"type": "o",
//"width": 130
//}, {
//"height": 133,
//"url": "https://sun9-53.u...BAoA&type=album",
//"type": "p",
//"width": 200
//}, {
//"height": 213,
//"url": "https://sun9-53.u...F9H0&type=album",
//"type": "q",
//"width": 320
//}, {
//"height": 340,
//"url": "https://sun9-53.u..._3pk&type=album",
//"type": "r",
//"width": 510
//}, {
//"height": 47,
//"url": "https://sun1-88.u..._Rrs&type=album",
//"type": "s",
//"width": 75
//}, {
//"height": 377,
//"url": "https://sun9-53.u...Yr7o&type=album",
//"type": "x",
//"width": 604
//}, {
//"height": 500,
//"url": "https://sun9-53.u...z55U&type=album",
//"type": "y",
//"width": 800
//}],
//"text": "",
//"user_id": 100
//}
//}]
