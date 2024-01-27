//
//  StoryWithTwist.swift
//  StoryTime
//
//  Created by mitchell tucker on 1/22/24.
//

import Foundation

// MARK: - StoryWithTwist
struct StoryWithTwist: Codable {
    let path: [Path]?
}

// MARK: - Path
struct Path: Codable {
    let title, body, hashID: String?
    let publishedAt: String?
    let genre: JSONNull?
    let tags: [String]?
    let twists: JSONNull?
    let nickname, status, monetizationOption, summary: String?
    let purchasedTwists: [PurchasedTwist]?

    enum CodingKeys: String, CodingKey {
        case title, body
        case hashID = "hashId"
        case publishedAt, genre, tags, twists, nickname, status
        case monetizationOption = "monetization_option"
        case summary, purchasedTwists
    }
}

// MARK: - PurchasedTwist
struct PurchasedTwist: Codable {
    let title, hashID: String?
    let publishedAt: String?
    let nickname: String?
    let purchased: Bool?
    let purchasedForAmount: Int?
    let ismature: Bool?
    let isuserauthor: Bool?
    let status: String?
    let childTwistCount: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case hashID = "hashId"
        case publishedAt, nickname, purchased, purchasedForAmount, ismature, isuserauthor, status, childTwistCount
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

