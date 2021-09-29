//
//  Settings.swift
//  Pandemify
//
//  Created by Anda Tilea on 05.08.2021.
//

import UIKit

class Settings {
    // for the light/dark mode
    var nightMode: Bool = false
    let defaults = UserDefaults.standard
    func assignBackground(currentView: UIView,
                          currentTitleLabel: UILabel?) {
        nightMode = defaults.bool(forKey: "nightMode")
        let imageView: UIImageView = UIImageView(frame: currentView.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        if nightMode == true {
            imageView.image = UIImage(named: "darkBackground")!
            imageView.center = currentView.center
            currentView.backgroundColor = UIColor(patternImage: UIImage(named: "darkBackground")!)
            currentTitleLabel?.textColor = .orange
        } else {
            imageView.image = UIImage(named: "backgroundLight")!
            currentView.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundLight")!)
            currentTitleLabel?.textColor = .black
        }
    }
    func chooseRightState(darkModeSwitch: UISwitch,
                          currentView: UIView,
                          currentTitleLabel: UILabel?) {
        if darkModeSwitch.isOn {
            defaults.set(true, forKey: "nightMode")
            assignBackground(currentView: currentView, currentTitleLabel: currentTitleLabel)
        } else {
            defaults.set(false, forKey: "nightMode")
            assignBackground(currentView: currentView, currentTitleLabel: currentTitleLabel)
        }
    }
    func getNightMode() -> Bool {
        return defaults.bool(forKey: "nightMode")
    }
    // for the Country Detail cells
    func setupLabels(label: UILabel) {
        label.backgroundColor = UIColor(patternImage: UIImage(named: "botticelli")!)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.clipsToBounds = true
    }
}
