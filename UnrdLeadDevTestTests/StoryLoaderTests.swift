//
//  StoryLoaderTests.swift
//  UnrdLeadDevTestTests
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest

class StoryLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

protocol HTTPClient {
    func load()
}

final class StoryLoaderTests: XCTest {
    
    func test_init_DoesnNotLoadData() {
        let client = HTTPClientSpy()
        _ = StoryLoader(client: client)
        XCTAssertNil(client.requestedURL)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func load() {
        
    }
}
