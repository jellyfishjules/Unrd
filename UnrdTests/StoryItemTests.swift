//
//  StoryItemTests.swift
//  UnrdTests
//
//  Created by Julian Ramkissoon on 01/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import Unrd

final class StoryItemTests: XCTestCase {
    
    func test_heroVideo_ReturnsFirstIntroVideo() {
        let item = makeStory(id: 0, name: "name", shortSummary: "short summary", fullSummary: "full summary", introVideos: [MediaItem(resourceUri: URL(string: "https://d1puk6yab42f06.cloudfront.net/9e980267ac53246a65cefda96d33491e379ee8fddd46e6262c4fee7ae9e826a4_60bd18b18278638ed90046239c8e2e9e.jpg")), MediaItem(resourceUri: URL(string: "https://asecondURL.jpg"))])
        
        XCTAssertEqual(item.story.heroVideo?.resourceUri?.absoluteString, "https://d1puk6yab42f06.cloudfront.net/9e980267ac53246a65cefda96d33491e379ee8fddd46e6262c4fee7ae9e826a4_60bd18b18278638ed90046239c8e2e9e.jpg")
    }
}
