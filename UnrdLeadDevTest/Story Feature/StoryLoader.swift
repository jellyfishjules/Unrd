//
//  StoryLoader.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

enum LoadStoryResult {
    case success(StoryItem)
    case fail(Error)
}

protocol StoryLoader {
    func load(completion: @escaping (LoadStoryResult) -> Void)
}
