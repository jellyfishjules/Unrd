//
//  StoryLoader.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 28/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public class StoryLoader: StoryLoading {
    private let client: HTTPClient
    private let url: URL
    
    public typealias Result = LoadStoryResult

    public enum Error: Swift.Error {
        case general
        case invalidData
    }
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (LoadStoryResult) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data):
                if let item = try? StoryItemMapper.map(data) {
                    if Thread.isMainThread {
                        completion(.success(item))
                    } else {
                        DispatchQueue.main.async {
                            completion(.success(item))
                        }
                    }
                } else {
                    completion(.fail(StoryLoader.Error.invalidData))
                }
            case .fail:
                completion(.fail(StoryLoader.Error.general))
            }
        }
    }
}




