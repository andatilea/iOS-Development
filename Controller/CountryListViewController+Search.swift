//
//  CountryListViewController+Search.swift
//  Pandemify
//
//  Created by Anda Tilea on 26.08.2021.
//

import UIKit

extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isBlank {
            settingCountryData(countriesData ?? [""])
            self.tableView.reloadData()
            return
        }
        var filteredCountryData: [String] = []
        let text = searchText.lowercased()
        for item in (countriesData ?? [""]) {
            let lowercasedItem = item.lowercased()
            if lowercasedItem.contains(text) {
                filteredCountryData.append(item)
            }
        }
        settingCountryData(filteredCountryData)
        self.tableView.reloadData()
    }
    func setupSearchBar() {
        nightMode = defaults.bool(forKey: "nightMode")
        searchBar.barTintColor = colorHelper.determineTintColor(darkModeSwitch: nightMode)
        searchBar.searchTextField.backgroundColor = colorHelper.determineColorSectionAndSearchBar(darkModeSwitch:
                                                                                                    nightMode)
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
           let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            // Magnifying glass
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor.init(red: 0.5176, green: 0.2745, blue: 0.1804, alpha: 1)
        }
    }
}
