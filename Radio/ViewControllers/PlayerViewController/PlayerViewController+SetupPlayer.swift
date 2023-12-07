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
    func setupPlayer(withURL: String) {
        self.playerItem = nil
        self.player = nil
        self.playerItem = AVPlayerItem(url: URL(string: withURL) ?? URL(fileURLWithPath: ""))
        self.player = AVPlayer(playerItem: self.playerItem)
        let _ = self.playAudio()
        self.playPauseImageView.image = UIImage(named: "pause")
    }
}
