//
//  Helpers.swift
//  UnrdTests
//
//  Created by Julian Ramkissoon on 01/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Unrd

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
