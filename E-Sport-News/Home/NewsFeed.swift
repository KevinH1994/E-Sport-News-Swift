//
//  NewsFeed.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 02.11.22.
//

import Foundation

struct NewsFeed: Codable {
    var titel: String?
    var description: String?
    var thumnail: String?
    
}


struct News: Codable {
    var news: Array<NewsFeed>?
}
