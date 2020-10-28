//
//  Chat.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

struct Chat: Equatable {
    let chatId: Int
    let timelineId: Int
    let name: String
    let price: Float
    let isGroup: Bool
    let isLocked: Bool
    let displayName: String
    let owned: String?
}
