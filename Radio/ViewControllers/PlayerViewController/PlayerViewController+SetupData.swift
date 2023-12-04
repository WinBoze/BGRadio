//
//  PlayerViewController+SetupData.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import Foundation
import UIKit

extension PlayerViewController {
    func setupData(forStation: Station) {
        self.radioNameLabel.text = forStation.radioName! + " "
        self.artistImageView.kf.setImage(with: URL(string: forStation.radioPic ?? ""), placeholder: UIImage())
        if (self.savedStations?.first(where: {$0.id == currentStation?.id}) != nil) {
            self.favoriteBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            self.favoriteBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    func getSavedStations() {
        self.savedStations = []
        guard let savedStat = UserDefaults.standard.object(forKey: "savedStations") as? Data else { return }
        do {
            let decoder = JSONDecoder()
            let saved = try decoder.decode([Station].self, from: savedStat)
            self.savedStations = saved
        } catch let err {
            print(err)
        }
    }
    
    func saveStationsLocal() {
        do {
            let encoder = JSONEncoder()
            let toSaveStations = try encoder.encode(self.savedStations)
            UserDefaults.standard.setValue(toSaveStations, forKey: "savedStations")
        } catch let err {
            print(err)
        }
    }
}
