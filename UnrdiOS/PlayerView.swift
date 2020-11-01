//
//  PlayerView.swift
//  UnrdiOS
//
//  Created by Julian Ramkissoon on 01/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation
import  AVKit

/*
 Reference: https://medium.com/flawless-app-stories/build-video-player-in-ios-i-avplayer-43cd1060dbdc
 */

public class PlayerView: UIView {
    
    private (set) public var url: URL?
    
    public func configure(with URL: URL) {
        self.url = URL
        let asset = AVAsset(url: URL)
        self.player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        player?.play()
    }
    
    public override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    private(set) public var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        
        set {
            playerLayer.player = newValue
        }
        
    }
}
