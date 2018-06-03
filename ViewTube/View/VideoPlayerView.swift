//
//  VideoPlayerView.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/2/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        let path = "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8"
        if let url = URL(string: path) {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
