//
//  RadioStationTableViewCell.swift
//  Radio
//
//  Created by Petko Tankov on 2.12.23.
//

import UIKit

class RadioStationTableViewCell: UITableViewCell {
    var identifier = "RadioStationTableViewCell"
    @IBOutlet weak var stationLogo: UIImageView!
    @IBOutlet weak var stationTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
