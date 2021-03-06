//
//  StoryItem.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public struct StoryItem: Equatable, Decodable {

    public let storyId: Int
    public let name: String
    public let shortSumary: String
    public let fullSummary: String
    public let introVideos: [MediaItem]?
    public let heroVideo: MediaItem?
    
    public init(storyId: Int, name: String, shortSummary: String, fullSummary: String, introVideos: [MediaItem]?) {
        self.storyId = storyId
        self.name = name
        self.shortSumary = shortSummary
        self.fullSummary = fullSummary
        self.introVideos = introVideos
        self.heroVideo = introVideos?.first
    }
}
