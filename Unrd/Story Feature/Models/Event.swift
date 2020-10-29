//
//  Event.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

struct Event: Equatable {
    let type: String
    let sequence: Int
    let data: EventData
    let hasOptions: Bool
}


