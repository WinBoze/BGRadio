//
//  PlayerViewController.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import UIKit
import Kingfisher
import MarqueeLabel
import AVKit
import MediaPlayer

class PlayerViewController: UIViewController {
    var currentStation: Station?
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    
    var savedStations: [Station]?

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var holderView: UIView! {
        didSet {
            holderView.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var helperBackView: UIView! {
        didSet {
            helperBackView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            helperBackView.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var radioNameLabel: MarqueeLabel! {
        didSet {
            radioNameLabel.animationDelay = 0
        }
    }
    @IBOutlet weak var artistImageView: UIImageView! {
        didSet {
            artistImageView.backgroundColor = .darkGray
            artistImageView.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var playPauseImageView: UIImageView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImageView.image = UIImage(named: "background" + "\(Int.random(in: 1..<4))")
        self.setupTapGesture()
        self.setupData(forStation: currentStation!)
        self.setupPlayer()
        self.setupRemoteCommandCenter()

        savedStations = []
    }
    
    
    
    
    
    
    
    
    
    func setupData(forStation: Station) {
        self.radioNameLabel.text = forStation.radioName! + " "
        self.artistImageView.kf.setImage(with: URL(string: forStation.radioPic ?? ""), placeholder: UIImage())
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        let _ = self.pauseAudio()
        self.playerItem = nil
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

