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

final class StoryViewController: UIViewController {
    
    private var loader: StoryLoading?
    
    convenience init(loader: StoryLoading) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader?.load(completion: { (_) in
            
        })
    }
}


final class StoryViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadStory() {
        let loader = StoryLoaderSpy()
        let _ = StoryViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCount, 0)
    }
    
    func test_viewDidLoad_loadsStory() {
        let loader = StoryLoaderSpy()
        let sut = StoryViewController(loader: loader)
        
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
