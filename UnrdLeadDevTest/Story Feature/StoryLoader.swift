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
            case .success:
                completion(.fail(.invalidData))
            case .fail:
                completion(.fail(.general))
            }
        }
    }
}

public enum HTTPClientResult {
    case success(Data)
    case fail(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

