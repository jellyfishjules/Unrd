//
//  StoryViewControllerTests.swift
//  UnrdiOSTests
//
//  Created by Julian Ramkissoon on 29/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import UIKit
import Unrd
import UnrdiOS

final class StoryViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadStoryUntilViewIsLoaded() {
        let loader = StoryLoaderSpy()
        let sut = StoryViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCount, 0)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCount, 1)
    }
}

class StoryLoaderSpy: StoryLoading {
    private(set) var loadCount = 0
    
    func load(completion: @escaping (LoadStoryResult) -> Void) {
        loadCount += 1
    }
}
