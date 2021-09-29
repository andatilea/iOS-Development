//
//  CountryListViewController+TableView.swift
//  Pandemify
//
//  Created by Anda Tilea on 25.08.2021.
//

import UIKit

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return countrySectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countryKey = countrySectionTitles[section]
        if let countryValues = countryDictionary[countryKey] {
            return countryValues.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell",
                                                       for: indexPath) as? CountryListTableViewCell else {
            return CountryListTableViewCell()
        }
        let countryKey = countrySectionTitles[indexPath.section]
        if let countryValues = countryDictionary[countryKey] {
            cell.setupCell(countryData: countryValues[indexPath.row],
                           abvData: abvDictionary[countryValues[indexPath.row]] ?? "")
            nightMode = defaults.bool(forKey: "nightMode")
            tableView.backgroundColor = colorHelper.determineColorCellAndTable(darkModeSwitch: nightMode)
            tableView.sectionIndexBackgroundColor = colorHelper.determineColorSectionAndSearchBar(darkModeSwitch:
                                                                                                    nightMode)
            tableView.sectionIndexColor = colorHelper.determineColorTextSectionIndex(darkModeSwitch: nightMode)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 25))
        returnedView.backgroundColor = colorHelper.determineColorHeaderTitle(darkModeSwitch: nightMode)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width, height: 25))
        label.font = .boldSystemFont(ofSize: 16.0)
        label.text = self.countrySectionTitles[section]
        returnedView.addSubview(label)
        return returnedView
    }
    // indexed table view
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return countrySectionTitles
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let countryKey = countrySectionTitles[indexPath.section]
        if let countryValues = countryDictionary[countryKey] {
            selectedCountryName = countryValues[indexPath.row]
        }
        return indexPath
    }
}
