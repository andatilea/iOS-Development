//
//  CountryDetailTableViewCell.swift
//  Pandemify
//
//  Created by Anda Tilea on 01.09.2021.
//

import UIKit

class CountryDetailTableViewCell: UITableViewCell {
    let colorHelper = ColorHelper()
    var nightMode: Bool = false
    let defaults = UserDefaults.standard
    var perLevel: CGFloat = CGFloat(1.0)
    var row: Int = 0
    func setupCell(dataTitle: String,
                   dataValues: String) {
        nightMode = defaults.bool(forKey: "nightMode")
        backgroundColor = colorHelper.determineCellColor(perLevel: perLevel, row: row, darkModeSwitch: nightMode)
        detailTextLabel?.textColor = colorHelper.determineColorDetail(darkModeSwitch: nightMode)
        textLabel?.textColor = colorHelper.determineColorTitle(darkModeSwitch: nightMode)
        textLabel?.text = dataTitle
        detailTextLabel?.text = dataValues
    }
}
