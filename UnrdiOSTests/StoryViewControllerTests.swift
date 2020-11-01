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
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.storyCompletions.count, 0)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.storyCompletions.count, 1)
    }
    
    func test_viewDidLoad_ShowsLoadingIndictor() {
        let (sut, _) = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertTrue(sut.isShowingLoadingIndicator())
    }
    
    func test_viewDidLoad_HidesLoadingIndictorWhenStoryIsLoaded() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.simulateStoryLoaded(at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator())
    }
    
    func test_viewDidLoad_DoesNotShowLabelsUntilStoryIsSuccessfullyLoaded() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertFalse(sut.isShowingNameLabel())
        XCTAssertFalse(sut.isShowingShortSummaryLabel())
       
        loader.simulateStoryLoaded(at: 0, successfully: true)
       
        XCTAssertTrue(sut.isShowingNameLabel())
        XCTAssertTrue(sut.isShowingShortSummaryLabel())
    }
  
    func test_viewDidLoad_ShowsCorrectNameAndSummaryWhenStoryIsSuccessfullyLoaded() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
       
        loader.simulateStoryLoaded(at: 0, successfully: true)
       
        XCTAssertEqual(sut.nameLabel.text, "A Short Story Name")
        XCTAssertEqual(sut.shortSummaryLabel.text, "A short summary")
    }
    
    func test_viewDidLoad_ShowsNoVideoBeforeStoryLoads() {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
              
        XCTAssertNil(sut.heroVideo())
    }
    
    func test_viewDidLoad_LoadsVideoAfterStory() {
        let (sut, loader) = makeSUT()
       
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.urls.count, 0)
        
        loader.simulateStoryLoaded(at: 0, successfully: true)
       
        XCTAssertEqual(sut.heroVideo(), URL(string: "https://d1puk6yab42f06.cloudfront.net/9e980267ac53246a65cefda96d33491e379ee8fddd46e6262c4fee7ae9e826a4_60bd18b18278638ed90046239c8e2e9e.jpg")!)
    }
    
    private func makeSUT() -> (sut: StoryViewController, loader: StoryLoaderSpy) {
        let loader = StoryLoaderSpy()
        let sut = StoryUIComposer.composeStoryWith(storyLoader: loader)
        return (sut, loader)
    }
}

private extension StoryViewController {
    func isShowingLoadingIndicator() -> Bool {
        return !loadingIndicator.isHidden
    }
    
    func isShowingNameLabel() -> Bool {
        return nameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
    }
    
    func isShowingShortSummaryLabel() -> Bool {
        return shortSummaryLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""
    }
    
    func heroVideo() -> URL? {
        return videoViewContainer?.url
    }
}

class StoryLoaderSpy: StoryLoading {
    private(set) var storyCompletions = [(LoadStoryResult) -> Void]()
    private(set) var urls = [URL]()
//    private(set) var imagecompletions = [(ImageLoading.Result) -> Void]()

    //MARK: - StoryLoading
    
    func load(completion: @escaping (LoadStoryResult) -> Void) {
        storyCompletions.append(completion)
    }

    func simulateStoryLoaded(at index: Int, successfully: Bool = false) {
        if successfully {
            storyCompletions[index](.success(makeStory(id: 123, name: "A Short Story Name", shortSummary: "A short summary", fullSummary: "A full summary...", introVideos:[ makeMediaItem(resourceUri: URL(string: "https://d1puk6yab42f06.cloudfront.net/9e980267ac53246a65cefda96d33491e379ee8fddd46e6262c4fee7ae9e826a4_60bd18b18278638ed90046239c8e2e9e.jpg")!)]).story))
        } else {
            storyCompletions[index](.fail(NSError(domain: "Test", code: 0)))
        }
    }
    
    //Helpers: -
    
    func makeStory(id: Int, name: String, shortSummary: String, fullSummary: String, introVideos: [MediaItem]) -> (story: StoryItem, json: [String: Any]) {
        let story = StoryItem(storyId: id, name: name, shortSummary: shortSummary, fullSummary: fullSummary, introVideos: introVideos)
        let videosJSON = ["resource_uri": story.introVideos![0].resourceUri!.absoluteString]
        
        let storyJSON: [String: Any] = ["story_id": story.storyId,
                                        "name": story.name,
                                        "short_summary": story.shortSumary,
                                        "full_summary": story.fullSummary,
                                        "intro_video": [videosJSON]]
        
        let validJSON = ["result": storyJSON]
        
        return (story, validJSON)
    }

    private func makeMediaItem(resourceUri: URL?) -> MediaItem {
        return MediaItem(resourceUri: resourceUri)
    }

}

extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
