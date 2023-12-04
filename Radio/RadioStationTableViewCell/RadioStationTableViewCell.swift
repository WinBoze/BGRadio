//
//  RadioStationTableViewCell.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import UIKit

class RadioStationTableViewCell: UITableViewCell {
    @IBOutlet weak var holderView: UIView! {
        didSet {
            holderView.layer.cornerRadius = 10
            holderView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var stationLogo: UIImageView! {
        didSet {
            stationLogo.layer.cornerRadius = 10
            stationLogo.layer.masksToBounds = true
            stationLogo.layer.borderWidth = 1.0
            stationLogo.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var stationTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
