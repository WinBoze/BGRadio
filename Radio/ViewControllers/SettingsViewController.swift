//
//  SettingsViewController.swift
//  Radio
//
//  Created by Petko Tankov on 4.12.23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "savedStations")

    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
