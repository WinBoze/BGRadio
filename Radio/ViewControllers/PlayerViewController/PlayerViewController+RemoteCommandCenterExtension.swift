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
        self.player.play()
        self.updateMPInfoCenter(artist: currentStation?.radioName ?? "", song: currentStation?.radioName ?? "", imageURLString: currentStation?.radioPic ?? "")
        return .success
    }
    
    @objc func pauseAudio() -> MPRemoteCommandHandlerStatus  {
        self.player.pause()
        self.updateMPInfoCenter(artist: "", song: "", imageURLString: "")
        return .success
    }
    
    func updateMPInfoCenter(artist: String, song: String, imageURLString: String) {
        DispatchQueue.background(background: {
            var info = [String : Any]()
            info[MPMediaItemPropertyTitle] = song
            let imageUrl = URL(string: imageURLString)
            let imageData = try? Data(contentsOf: (imageUrl ?? URL(string: "https://cdn-icons-png.flaticon.com/512/74/74101.png"))!)
            info[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: UIImage(data: imageData ?? Data())!.size, requestHandler: { (size) -> UIImage in
                return UIImage(data: imageData ?? Data()) ?? UIImage()
            })
            info[MPMediaItemPropertyArtist] = artist
            MPNowPlayingInfoCenter.default().nowPlayingInfo = info
        }, completion:{
            // when background job finished, do something in main thread
        })
    }
}
