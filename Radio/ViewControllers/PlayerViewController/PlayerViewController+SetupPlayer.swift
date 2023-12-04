//
//  PlayerViewController+SetupPlayer.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import UIKit
import AVKit

extension PlayerViewController {
    func setupPlayer() {
        self.playerItem = AVPlayerItem(url: URL(string: currentStation?.radioUrl ?? "") ?? URL(fileURLWithPath: ""))
        self.player = AVPlayer(playerItem: self.playerItem)
        let _ = self.playAudio()
        self.playPauseImageView.image = UIImage(named: "pause")
    }
}
