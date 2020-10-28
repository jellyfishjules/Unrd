//
//  StoryLoaderTests.swift
//  UnrdLeadDevTestTests
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import UnrdLeadDevTest

final class StoryLoaderTests: XCTestCase {
    
    func test_init_doesNotLoadData() {
        let client = HTTPClientSpy()
        _ = makeSUT()
       
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_loadsWithCorrectURL() {
        let givenURL = URL(string: "http://www.anyURL.com")!
        let (sut, client) = makeSUT(url: givenURL)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [givenURL])
    }
    
    func test_loadTwice_loadsWithCorrectURLsTwice() {
        let givenURL = URL(string: "http://www.anyURL.com")!
        let (sut, client) = makeSUT(url: givenURL)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [givenURL, givenURL])
    }
    
    // - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://anyURL")!) -> (sut: StoryLoader, client:  HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (StoryLoader(client: client, url: url), client)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURLs = [URL]()

    func get(from url: URL) {
        requestedURLs.append(url)
    }
}
