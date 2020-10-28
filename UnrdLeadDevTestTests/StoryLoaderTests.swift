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
    
    func test_loadDeliversError_whenClientErrors() {
        let (sut, client) = makeSUT()
        let givenError = NSError(domain: "test", code: 0)
        
        var capturedResults = [StoryLoader.Result]()
        sut.load { result in
            capturedResults.append(result)
        }
        
        client.complete(with: givenError)
        
        XCTAssertEqual(capturedResults, [.fail(.general)])
    }
    
    func test_loadDeliversError_WhenJSONIsInvalidButClientDoesNotError() {
        let (sut, client) = makeSUT()
        
        var capturedResults = [StoryLoader.Result]()
        sut.load { result in
            capturedResults.append(result)
        }
        let invalidJSON = Data("invalidJSON".utf8)
        client.complete(with: invalidJSON)
        
        XCTAssertEqual(capturedResults, [.fail(.invalidData)])
    }
    
    
    // - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://anyURL")!) -> (sut: StoryLoader, client:  HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (StoryLoader(client: client, url: url), client)
    }
}

private class HTTPClientSpy: HTTPClient {
    var requestedURLs = [URL]()
    var capturedCompletions = [(HTTPClientResult) -> Void]()
    
    func get(from url: URL, completion: @escaping ((HTTPClientResult) -> Void)) {
        requestedURLs.append(url)
        capturedCompletions.append(completion)
    }
    
    func complete(with error: Error) {
        capturedCompletions[0](.fail(error))
    }
    
    func complete(with data: Data) {
        capturedCompletions[0](.success(data))
    }
}
