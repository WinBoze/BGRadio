//
//  PlayerViewController+TapGestureExtension.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import UIKit

extension PlayerViewController {
    func setupTapGesture() {
        let tapPlayPause = UITapGestureRecognizer(target: self, action: #selector(playPausePressed))
        playPauseImageView.isUserInteractionEnabled = true
        playPauseImageView.addGestureRecognizer(tapPlayPause)
    }
}
