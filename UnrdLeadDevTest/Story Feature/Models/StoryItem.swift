//
//  StoryItem.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public struct StoryItem: Equatable {
    let storyId: Int
    let languageId: Int
    let genreId: Int
    let mainCharacterId: Int
    let name: String
    let shortSumary: String
    let fullSummary: String
    let duration: String
    let price: Float
    let ageFrom: Int
    let ageTo: Int
    let introVideoSequence: Int
    let storyStartSequence: Int
    let storyEndSequence: Int
    let passcodeClue: String?
    let passcodeValue: String?
    let is_coming_soon: Bool
    let is_in_testing: Bool
    let is_early_access: Bool
    let is_published: Bool
    let is_featured: Bool
    let releaseDate: Date?
    let releaseTimezone: String?
    let createdDate: Date
    let updatedDate: Date
    let listImages: [MediaItem]?
    let previewMedia: [MediaItem]?
    let introVideos: [MediaItem]?
    let backgroundImages: [MediaItem]?
    let publicationStatus: String
    let characters: [Character]
    let timelines: [Timeline]
    let isOwned: Bool
    let purchaseDate: Date
    let lastProgressReport: String?
    let progress: Int
    let purchasedItems: [PurchasedItem]
}
