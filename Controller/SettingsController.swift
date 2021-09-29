//
//  SettingsController.swift
//  Pandemify
//
//  Created by Anda Tilea on 26.08.2021.
//

import UIKit

class SettingsController: UITableViewController {
    var nightMode: Bool = false
    @IBOutlet weak var darkModeSwitch: UISwitch!
    let lightSetting = Settings()
    let latestDataLabel = LatestDataViewController().titleLabel
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSetting.assignBackground(currentView: self.view, currentTitleLabel: nil)
        self.tableView.headerView(forSection: 0)?.detailTextLabel?.textColor = .red
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        darkModeSwitch.setOn(lightSetting.getNightMode(), animated: false)
    }
    @IBAction func darkModeSwitchAction(_ sender: UISwitch) {
        lightSetting.chooseRightState(darkModeSwitch: darkModeSwitch,
                                      currentView: self.view,
                                      currentTitleLabel: latestDataLabel)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView()
        let label = UILabel()
        switch section {
        case 0:
            label.frame = CGRect(x: 0, y: 18, width: self.view.frame.width, height: 30)
            label.text = "Appearance"
        case 1:
            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
            label.text = "Help"
        default:
            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        }
        label.textColor = .systemGray4
        returnedView.addSubview(label)
        return returnedView
    }
}
