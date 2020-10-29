//
//  StoryLoader.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public enum LoadStoryResult {
    case success(StoryItem)
    case fail(Error)
}

public protocol StoryLoading {
    func load(completion: @escaping (LoadStoryResult) -> Void)
}
