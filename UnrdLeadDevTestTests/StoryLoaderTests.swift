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
        
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [givenURL])
    }
    
    func test_loadTwice_loadsWithCorrectURLsTwice() {
        let givenURL = URL(string: "http://www.anyURL.com")!
        let (sut, client) = makeSUT(url: givenURL)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [givenURL, givenURL])
    }
    
    func test_deliversError_whenClientErrors() {
        let (sut, client) = makeSUT()
        let givenError = NSError(domain: "test", code: 0)
        
        var capturedErrors = [StoryLoader.Error]()
        sut.load { error in
            capturedErrors.append(error)
        }
        
        client.capturedCompletions[0](givenError)
        
        XCTAssertEqual(capturedErrors, [.general])
        
    }
    
    // - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://anyURL")!) -> (sut: StoryLoader, client:  HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (StoryLoader(client: client, url: url), client)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURLs = [URL]()
    var capturedCompletions = [(Error) -> Void]()
    
    func get(from url: URL, completion: @escaping ((Error) -> Void)) {
        requestedURLs.append(url)
        capturedCompletions.append(completion)
    }
}
