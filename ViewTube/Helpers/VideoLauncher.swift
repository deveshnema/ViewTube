//
//  VideoLauncher.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/2/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

class VideoLauncher {
    
    func showVideoPlayer() {
        if let keywindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keywindow.frame)
            view.backgroundColor = UIColor.red
            view.frame = CGRect(x: keywindow.frame.width - 30, y: keywindow.frame.height - 30, width: 30 , height: 30)
            
            let height = keywindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keywindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keywindow.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                view.frame = keywindow.frame
            }, completion: { completedAnimation in
                UIApplication.shared.isStatusBarHidden = true
                
            })
        }
    }
    
}
