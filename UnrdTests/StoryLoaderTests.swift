//
//  StoryLoaderTests.swift
//  UnrdTests
//
//  Created by Julian Ramkissoon on 27/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import Unrd

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
        
        sut.load { result in
            switch result {
            case let .fail(error as StoryLoader.Error):
                XCTAssertEqual(error, .general)
            default:
                XCTFail("Expected StoryLoader.Error.general, got \(result) instead")
            }
        }
        
        client.complete(with: givenError)
    }
    
    func test_loadDeliversError_WhenJSONIsInvalidButClientDoesNotError() {
        let (sut, client) = makeSUT()
        
        sut.load { result in
            switch result {
            case let .fail(error as StoryLoader.Error):
                XCTAssertEqual(error, .invalidData)
            default:
                XCTFail("Expected StoryLoader.Error.invalidData, got \(result) instead")
            }
        }
        let invalidJSON = Data("invalidJSON".utf8)
        client.complete(with: invalidJSON)
    }
    
    func test_loadDeliversStory_WhenJSONIsValid() {
        let (sut, client) = makeSUT()
        let (expectedStory, json) = makeStory(id: 123, name: "some name", shortSummary: "short summary", fullSummary: "full summary", listImages: [MediaItem (resourceUri: URL(string: "http://anyurl.com")!)])
       
        sut.load { result in
            switch result {
            case let .success(story):
                XCTAssertEqual(story, expectedStory)
            default:
                XCTFail("Expected \(expectedStory), got \(result) instead")
            }
        }
        
        let data = try! JSONSerialization.data(withJSONObject: json)
       
        client.complete(with: data)
    }
    
    // - Helpers
    
    private func makeSUT(url: URL = URL(string: "http://anyURL")!) -> (sut: StoryLoader, client:  HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (StoryLoader(client: client, url: url), client)
    }
    
    private func makeStory(id: Int, name: String, shortSummary: String, fullSummary: String, listImages: [MediaItem]) -> (story: StoryItem, json: [String: Any]) {
        let story = StoryItem(storyId: id, name: name, shortSummary: shortSummary, fullSummary: fullSummary, listImages: listImages)
        let imagesJSON = ["resource_uri": story.listImages![0].resourceUri!.absoluteString]
        
        let storyJSON: [String: Any] = ["story_id": story.storyId,
                                        "name": story.name,
                                        "short_summary": story.shortSumary,
                                        "full_summary": story.fullSummary,
                                        "list_image": [imagesJSON]]
        
        let validJSON = ["result": storyJSON]
        
        return (story, validJSON)
    }
    
    private func makeMediaItem(resourceUri: URL?) -> MediaItem {
        return MediaItem(resourceUri: resourceUri)
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
