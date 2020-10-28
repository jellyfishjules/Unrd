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
    let url: URL
   
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class StoryLoaderTests: XCTestCase {
    
    func test_init_doesNotLoadData() {
        let client = HTTPClientSpy()
        _ = makeSUT()
       
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_LoadsWithCorrectURL() {
        let givenURL = URL(string: "http://www.anyURL.com")!
        let (sut, client) = makeSUT(url: givenURL)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, givenURL)
    }
    
    // - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://anyURL")!) -> (sut: StoryLoader, client:  HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (StoryLoader(client: client, url: url), client)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}
