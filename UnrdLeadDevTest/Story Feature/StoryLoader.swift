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
   
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load() {
        client.get(from: url)
    }
}

public protocol HTTPClient {
    func get(from url: URL)
}

