//
//  StoryViewModel.swift
//  UnrdiOS
//
//  Created by Julian Ramkissoon on 01/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation
import Unrd

final class StoryViewModel {
    private let storyLoader: StoryLoading
    typealias Observer<T> = (T) -> Void
    
    var onLoadingStateChange: Observer<Bool>?
    var onStoryLoad: Observer<StoryItem>?
    
    init(loader: StoryLoading) {
        self.storyLoader = loader
    }
    
    func viewDidLoad() {
        onLoadingStateChange?(true)
        storyLoader.load(completion: { [weak self]  ( result ) in
            self?.onLoadingStateChange?(false)
            switch result {
            case let .success(story):
                self?.onStoryLoad?(story)
            default:
                break
            }
        })
    }
}
