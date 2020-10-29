//
//  UnrdAPIEndToEndTests.swift
//  UnrdAPIEndToEndTests
//
//  Created by Julian Ramkissoon on 29/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import Unrd

class UnrdAPIEndToEndTests: XCTestCase {

    func test_endToEndPAIRequest_matchesExpectedData() {
        let url = URL(string: "https://s3-eu-west-1.amazonaws.com/unrd-scratch/resp.json")!
        let client = URLSessionHTTPClient()

        let loader = StoryLoader(client: client, url: url)

        let exp = expectation(description: "wait for response")
        
        loader.load { (result) in
            switch result {
            case let .success(story):
                XCTAssertEqual(story.name, "My Last 3 Days")
            default:
                XCTFail("Expected strory with name - My Last 3 Days, got \(result) intead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
    }
}
