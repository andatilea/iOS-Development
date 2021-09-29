//
//  CountryListTableViewCell.swift
//  Pandemify
//
//  Created by Anda Tilea on 23.08.2021.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageToUse: UIImageView!
    let colorHelper = ColorHelper()
    var nightMode: Bool = false
    let defaults = UserDefaults.standard
    func setupCell(countryData: String,
                   abvData: String) {
        nightMode = defaults.bool(forKey: "nightMode")
        backgroundColor = colorHelper.determineColorCellAndTable(darkModeSwitch: nightMode)
        detailTextLabel?.textColor = colorHelper.determineColorDetail(darkModeSwitch: nightMode)
        textLabel?.textColor = colorHelper.determineColorTitle(darkModeSwitch: nightMode)
        self.indentationWidth = 45
        self.indentationLevel = 1
        imageToUse.image = UIImage(named: "planet11")
        textLabel?.text = countryData
        detailTextLabel?.text = abvData
    }
}
