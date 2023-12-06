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
        self.getSavedStations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupData(forStation: currentStation!)
        self.setupPlayer()
        self.setupRemoteCommandCenter()
    }
}

