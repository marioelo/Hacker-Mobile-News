//
//  News.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 07-05-21.
//

import Foundation

struct HNResponse: Codable {
    let hits: [StoryServerModel]
}

struct StoryServerModel: Codable {
    let storyId: Int?
    let storyTitle: String?
    let title: String?
    let author: String?
    let storyUrl: String?
    let createdAt: Date?
}
