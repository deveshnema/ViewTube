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

    let activityIndicator : UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        av.translatesAutoresizingMaskIntoConstraints = false
        av.startAnimating()
        return av
    }()
    
    var isPlaying = false
    
    lazy var playPauseButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(UIImage(named: "pause"), for: UIControlState.normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(handlePlayPause), for: UIControlEvents.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    @objc func handlePlayPause() {
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: UIControlState.normal)
            skipButton.isHidden = false
        } else {
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: UIControlState.normal)
            skipButton.isHidden = true
        }
        
        isPlaying = !isPlaying
    }
    
    let skipButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setImage(UIImage(named: "skip"), for: UIControlState.normal)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    var player: AVPlayer?
    
    fileprivate func setupPlayerView() {
        let path = "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8"
        if let url = URL(string: path) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //this is when the player is ready and starts to play
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicator.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            playPauseButton.isHidden = false
            isPlaying = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black

        setupPlayerView()

        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        controlsContainerView.addSubview(skipButton)
        skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        skipButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
