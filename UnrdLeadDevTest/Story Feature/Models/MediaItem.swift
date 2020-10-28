//
//  MediaItem.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

struct MediaItem: Equatable {
    enum MediaType {
        case image, video
    }
    
    let resource_id: Int
    let resource_fid: String
    let mediaType: MediaType
    let resource_uri: URL?
    let resourcePreset: String
    let rsourceProcessed: Bool
    let resourceProgress: Int
}
