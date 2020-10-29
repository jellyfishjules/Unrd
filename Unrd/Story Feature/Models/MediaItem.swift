//
//  MediaItem.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public struct MediaItem: Equatable, Decodable {
    
    public init(resourceUri: URL?) {
        self.resourceUri = resourceUri
    }
    public let resourceUri: URL?

}
