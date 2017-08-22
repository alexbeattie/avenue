//
//  MovieController.swift
//  ave6
//
//  Created by Alex Beattie on 8/14/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class MovieController: UIViewController {

   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideo()
    }
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "mercer", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
}
