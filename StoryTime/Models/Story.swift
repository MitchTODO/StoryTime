//
//  Stories.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/21/24.
//

import Foundation

// MARK: - WelcomeElement
struct Story: Codable {
    var title:String
    let hashID, body, updatedAt: String
    let tags: [String]
    let isDeletable: Bool
    let status: String
    let views: Int
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case hashID = "hashId"
        case body, title
        case updatedAt = "updated_at"
        case tags, isDeletable, status, views, summary
    }
}

typealias Stories = [Story]
