//
//  PlayerViewController+RemoteCommandCenterExtension.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import MediaPlayer
import UIKit

extension PlayerViewController {
    func setupRemoteCommandCenter() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(self.playAudio))
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(self, action: #selector(self.pauseAudio))
    }
    
    @objc func playAudio() -> MPRemoteCommandHandlerStatus {
        if player == nil {
            self.setupPlayer(withURL: currentStation?.radioUrl ?? "")
        } else {
            self.playPauseImageView.image = UIImage(named: "pause")
            self.player.play()
            self.updateMPInfoCenter(artist: currentStation?.radioName ?? "", song: currentStation?.radioName ?? "", imageURLString: currentStation?.radioPic ?? "")
        }
        return .success
    }
    
    @objc func pauseAudio() -> MPRemoteCommandHandlerStatus  {
        self.player.pause()
        self.updateMPInfoCenter(artist: "", song: "", imageURLString: "")
        self.playPauseImageView.image = UIImage(named: "play")
        return .success
    }
    
    func updateMPInfoCenter(artist: String, song: String, imageURLString: String) {
        DispatchQueue.background(background: {
            var info = [String : Any]()
            info[MPMediaItemPropertyTitle] = song
            let imageUrl = URL(string: imageURLString)
            let imageData = try? Data(contentsOf: (imageUrl ?? URL(string: "https://i.pinimg.com/originals/74/b8/16/74b81658df0417d6058f5ee60c0954a5.png"))!)
            info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize:
                                                                        (UIImage(data: imageData ?? Data()) ??
                                                                         UIImage(systemName: "AppIcon"))?.size ?? CGSize(), requestHandler: { (size) -> UIImage in
                return UIImage(data: imageData ?? Data()) ?? UIImage()
            })
            info[MPMediaItemPropertyArtist] = artist
            MPNowPlayingInfoCenter.default().nowPlayingInfo = info
        }, completion:{
            // when background job finished, do something in main thread
        })
    }
}
