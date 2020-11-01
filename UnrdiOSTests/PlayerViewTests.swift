//
//  PlayerViewTests.swift
//  UnrdiOSTests
//
//  Created by Julian Ramkissoon on 01/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import UnrdiOS
import  AVKit

final class PlayerViewTests: XCTestCase {
    func test_layerClass_isAVPlayerLayer() {
        let sut = PlayerView()
        
        XCTAssertTrue(sut.layer is AVPlayerLayer)
    }
    
    func test_configreWithURL_attemotsToPlayURL() {
        let sut = PlayerView()

        let expectedURL = URL(string: "https://anyURL.com")!
        sut.configure(with: expectedURL)
        
        XCTAssertEqual((sut.player?.currentItem?.asset as! AVURLAsset).url, expectedURL)
        XCTAssertEqual(sut.player?.rate, 1)
    }
}

