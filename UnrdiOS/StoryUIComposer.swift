//
//  StoryUIComposer.swift
//  UnrdiOS
//
//  Created by Julian Ramkissoon on 30/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

import UIKit
import Unrd

public final class StoryUIComposer {
    private init() {}
    
    public static func composeStoryWith(storyLoader: StoryLoading) -> StoryViewController {
        let bundle = Bundle(for: StoryViewController.self)
        let storyboard = UIStoryboard(name: "Story", bundle: bundle)
        let storyController = storyboard.instantiateInitialViewController() as! StoryViewController
        storyController.viewModel = StoryViewModel(loader: storyLoader)

        return storyController
    }
}
