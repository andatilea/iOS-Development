//
//  LatestDataViewController.swift
//  Pandemify
//
//  Created by Anda Tilea on 30.07.2021.
//

import UIKit

class LatestDataViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    let titleData = ["Total Cases Confirmed", "Total Recovered", "Total Deaths", "Active Cases",
                     "New Deaths", "New Cases", "Last Update:"]
    let imageArray = ["totalCases", "totalRecovered", "totalDeaths", "activeCases",
                      "newDeaths", "newCases", "lastUpdate"]
    var latestData: [String]?
    var nightMode: Bool = false
    let lightSetting = Settings()
    let colorHelper = ColorHelper()
    var error: Error?
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "nightMode")
        loadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        lightSetting.assignBackground(currentView: self.view, currentTitleLabel: titleLabel)
    }
    func loadData() {
        spinner.startAnimating()
        NetworkManager().fetchLatestData { [weak self] (latestData, error) in
            if error == nil {
                self?.latestData = latestData
                DispatchQueue.main.async {
                    self?.spinner.stopAnimating()
                    self?.spinner.hidesWhenStopped = true
                    self?.tableView.reloadData()
                }
            } else {
                self?.showErrorAlert(for: error, spinner: self?.spinner)
            }
        }
    }
}

extension LatestDataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LatestDataTableViewCell",
                                                       for: indexPath) as? LatestDataTableViewCell else {
            return LatestDataTableViewCell()
        }
        guard let latestData = latestData, latestData.count > indexPath.row else {
            return cell
        }
        let pictureAlert = UIImage(named: "pictureAlert")!
        let image = (UIImage(named: imageArray[indexPath.row])) ?? pictureAlert
        cell.setupCell(image: image,
                       latestData: latestData[indexPath.row],
                       titleData: titleData[indexPath.row])
        tableView.backgroundColor = colorHelper.determineColorCellAndTable(darkModeSwitch: nightMode)
        return cell
    }
}
