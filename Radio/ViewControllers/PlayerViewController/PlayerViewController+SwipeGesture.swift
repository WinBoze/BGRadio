//
//  PlayerViewController+SwipeGesture.swift
//  Radio
//
//  Created by Petko Tankov on 6.12.23.
//

import Foundation
import UIKit

extension PlayerViewController {
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(PlayerViewController.handleSwipe(gesture:)))
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.down:
            self.playPrevious()
        case UISwipeGestureRecognizer.Direction.up:
            self.playNext()
        case UISwipeGestureRecognizer.Direction.left:
            self.playNext()
        case UISwipeGestureRecognizer.Direction.right:
            self.playPrevious()
        default:
            print("other swipe")
        }
    }
    
    func playNext() {
        print("Play Next")
        self.pickRandomElement()
    }
    
    func playPrevious() {
        print("Play Prevous")
        self.pickRandomElement()
        
//        if let station = savedStations?[safe:(savedStations?.firstIndex(where: { $0.id == currentStation?.id }) ?? -100) - 1] {
//            self.currentStation = station
//            self.setupPlayer(withURL: currentStation?.radioUrl ?? "")
//            self.setupData(forStation: currentStation!)
//        }
    }
    
    func pickRandomElement() {
        let station = GlobalVariables.allStations.randomElement()
        self.currentStation = station
        self.setupPlayer(withURL: currentStation?.radioUrl ?? "")
        self.setupData(forStation: currentStation!)
    }
}
