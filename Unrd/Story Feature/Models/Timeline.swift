//
//  Timeline.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

struct Timeline: Equatable {
    let id: Int
    let name: String
    let isPrimary: Bool
    let isTerminal: Bool
    let createdDate: Date
    let updatedDate: Date
    let chats: [Chat]
    let events: [Event]
}
