//
//  StoryLoader.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 28/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public class StoryLoader {
    private let client: HTTPClient
    private let url: URL
   
    public enum Result: Equatable {
        case success(StoryItem)
        case fail(Error)
    }
    
    public enum Error: Swift.Error {
        case general
        case invalidData
    }
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data):
                if let item = try? StoryItemMapper.map(data) {
                    completion(.success(item))
                } else {
                    completion(.fail(.invalidData))
                }
            case .fail:
                completion(.fail(.general))
            }
        }
    }
}

private class StoryItemMapper {
    // - Internal models to encapsulate api domain specific naming details
    private struct Root: Decodable {
        let result: Item
    }

    private struct Item: Decodable {
        let story_id: Int
        let name: String
        let short_summary: String
        let full_summary: String
        let list_image: [ItemImage]?
        
        var storyItem: StoryItem {
            return StoryItem(storyId: story_id, name: name, shortSummary: short_summary, fullSummary:full_summary, listImages: list_image?.map { $0.mediaItem })
        }
    }

    private struct ItemImage: Decodable {
        let resource_uri: URL?
        
        var mediaItem: MediaItem {
            return MediaItem(resourceUri: resource_uri)
        }
    }
    
    static func map(_ data: Data) throws -> StoryItem? {
        return try? JSONDecoder().decode(Root.self, from: data).result.storyItem
    }
}



