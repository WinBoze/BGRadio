//
//  PlayerViewController+ButtonActions.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import UIKit

extension PlayerViewController {
    @IBAction func backBtnPressed(_ sender: Any) {
        let _ = self.pauseAudio()
        self.playerItem = nil
        self.saveStationsLocal()
        self.dismiss(animated: false)
    }
    
    @objc func playPausePressed() {
        if self.playPauseImageView.image == UIImage(named: "play") {
            let _ = self.playAudio()
            self.playPauseImageView.image = UIImage(named: "pause")
        } else {
            let _ = self.pauseAudio()
            self.playPauseImageView.image = UIImage(named: "play")
        }
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        if let index = self.savedStations?.firstIndex(of: currentStation!) {
            self.savedStations?.remove(at: index)
            self.favoriteBtn.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            self.savedStations?.append(currentStation!)
            self.favoriteBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
    }
}
