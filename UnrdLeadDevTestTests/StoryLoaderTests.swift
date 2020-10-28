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
    
    func load() {
        client.get(from: URL(string: "http://www.anyURL.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class StoryLoaderTests: XCTestCase {
    
    func test_init_doesNotLoadData() {
        let client = HTTPClientSpy()
        _ = StoryLoader(client: client)
       
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_LoadsWithCorrectURL() {
        let givenURL = URL(string: "http://www.anyURL.com")
        let client = HTTPClientSpy()
        let sut = StoryLoader(client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, givenURL)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}
