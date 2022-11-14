//
//  youtubeFeed.swift
//  E-Sport-News
//
//  Created by Kevin Hering on 10.11.22.
//

import Foundation

// MARK: - YoutubeV3
struct YoutubeV3: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
    let kind: String
    let videoID, channelID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
        case channelID = "channelId"
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: Date
    let channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    let publishTime: Date

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}

