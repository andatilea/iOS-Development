//
//  CountryListViewController.swift
//  Pandemify
//
//  Created by Anda Tilea on 23.08.2021.
//

import UIKit

class CountryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var countriesData: [String]?
    var abbreviationData: [String]?
    let defaults = UserDefaults.standard
    var nightMode: Bool = false
    let lightSetting = Settings()
    let colorHelper = ColorHelper()
    var countryDictionary = [String: [String]]()
    var countrySectionTitles = [String]()
    var abvDictionary = [String: String]()
    var selectedCountryName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSetting.assignBackground(currentView: self.view, currentTitleLabel: nil)
        loadData()
        settingCountryData(countriesData ?? [""])
        settingAbvDictionary()
        setupSearchBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        settingCountryData(countriesData ?? [""])
        settingAbvDictionary()
        tableView.reloadData()
    }
    func settingCountryData(_ countryDict: [String]) {
        countryDictionary.removeAll()
        countrySectionTitles.removeAll()
        for country in (countryDict) {
            // the first letter of each country name
            let countryKey = String(country.prefix(1))
            if var countryValues = countryDictionary[countryKey] {
                // the value in the dictionary -> the name of the country
                countryValues.append(country)
                countryDictionary[countryKey] = countryValues
            } else {
                countryDictionary[countryKey] = [country]
            }
        }
        // setting the section titles
        countrySectionTitles = [String](countryDictionary.keys)
        // sorting them alphabetically
        countrySectionTitles = countrySectionTitles.sorted(by: { $0 < $1 })
    }
    func loadData() {
        spinner.startAnimating()
        NetworkManager().fetchCountryListData { [weak self] (countriesData, abbreviationData, error) in
            if error == nil {
                self?.countriesData = countriesData
                self?.abbreviationData = abbreviationData
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
    func settingAbvDictionary() {
        guard let allCountries = countriesData?.enumerated() else { return }
        for (index, country) in allCountries {
            abvDictionary[country] = abbreviationData?[index] ?? ""
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CountryDetailViewController {
            let countryDetailViewController = segue.destination as? CountryDetailViewController
            countryDetailViewController?.countryName = selectedCountryName
        }
    }
}
