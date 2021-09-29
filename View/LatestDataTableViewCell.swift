//
//  LatestDataTableViewCell.swift
//  Pandemify
//
//  Created by Anda Tilea on 09.08.2021.
//

import UIKit

class LatestDataTableViewCell: UITableViewCell {
    @IBOutlet weak var imageToUse: UIImageView!
    let colorHelper = ColorHelper()
    var nightMode: Bool = false
    let defaults = UserDefaults.standard
    func setupCell(image: UIImage,
                   latestData: String,
                   titleData: String) {
        nightMode = defaults.bool(forKey: "nightMode")
        detailTextLabel?.textColor = colorHelper.determineColorDetail(darkModeSwitch: nightMode)
        backgroundColor = colorHelper.determineColorCellAndTable(darkModeSwitch: nightMode)
        self.indentationWidth = 65
        self.indentationLevel = 1
        imageToUse.image = image
        textLabel?.text = titleData
        detailTextLabel?.text = latestData
    }
}
