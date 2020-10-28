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
   
    public enum Error: Swift.Error {
        case general
    }
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        client.get(from: url) { error in
            completion(.general)
        }
    }
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error) -> Void)
}

