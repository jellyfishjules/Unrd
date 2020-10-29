//
//  EventData.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

struct EventData: Equatable {
    let chatMessageId: Int
    let chatId: Int
    let characterId: Int
    let mediaDuration: Float?
    let content: String
    let urlLabel: String?
    let sequence: Int
    let price: Float
    let isLocked: Bool
    let hasOptions: Bool
    let optionsTimeout: Int
    let createdDate: Date
    let updatedDate: Date
    let hasUrl: Bool
    let resourceId: String?
    let thumbResourceId: String?
    let owned: String?
}
