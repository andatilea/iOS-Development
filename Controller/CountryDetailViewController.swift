//
//  CountryDetailViewController.swift
//  Pandemify
//
//  Created by Anda Tilea on 01.09.2021.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var casesSectionLabel: UILabel!
    @IBOutlet weak var vaccinationSectionLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var vaccinationSpinner: UIActivityIndicatorView!
    @IBOutlet weak var tableViewPrim: UITableView!
    var countriesData: [String] = ["Number of Cases Confirmed", "Number of Deaths", "Last Updated"]
    var casesData: [String]?
    var vaccinesData: [String] = ["Number of Vaccination Doses", "Number of People Vaccinated",
                                  "Number of People Partially Vaccinated"]
    var vaccinesDataValues: [String]?
    @IBOutlet weak var tableViewVaccination: UITableView!
    var nightMode: Bool = false
    let lightSetting = Settings()
    let colorHelper = ColorHelper()
    var countryName: String?
    var lat: Double?
    var long: Double?
    var population: Int?
    var casesConfirmed: Int?
    var deaths: Int?
    var peopleFullyVaccinated: Int?
    var peoplePartiallyVaccinated: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSetting.assignBackground(currentView: self.view, currentTitleLabel: nil)
        setupScreen()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCasesData()
        loadVaccinationData()
    }
    func setupScreen() {
        lightSetting.setupLabels(label: casesSectionLabel)
        lightSetting.setupLabels(label: vaccinationSectionLabel)
    }
    func loadCasesData() {
        spinner.startAnimating()
        if ((countryName?.isBlank) != nil) {
            NetworkManager().fetchCountryDetailsCasesData(countryName: countryName ?? "") { [weak self] (result, error)
                in
                if error == nil {
                    let confirmed = result["confirmed"] ?? "Unknown"
                    let deaths = result["deaths"] ?? "Unknown"
                    self?.casesData = [confirmed]
                    self?.casesData?.append(deaths)
                    self?.casesData?.append(result["updated"] ?? "Unknown")
                    self?.lat = Double(result["lat"] ?? "0")
                    self?.long = Double(result["long"] ?? "0")
                    // for charts view
                    self?.casesConfirmed = Int(confirmed)
                    self?.deaths = Int(deaths)
                    self?.population = Int(result["population"] ?? "0")
                    DispatchQueue.main.async {
                        self?.spinner.stopAnimating()
                        self?.spinner.hidesWhenStopped = true
                        self?.tableViewPrim.reloadData()
                    }
                } else {
                    self?.showErrorAlert(for: error, spinner: self?.spinner)
                }
            }
        } else { return }
    }
    func loadVaccinationData() {
        vaccinationSpinner.startAnimating()
        if ((countryName?.isBlank) != nil) {
            NetworkManager().fetchCountryDetailsVaccinesData(countryName:
                                                                countryName ?? "") { [weak self] (result, error) in
                if error == nil {
                    let fullyVaccinated = result["people_vaccinated"] ?? "Unknown"
                    let partiallyVaccinated = result["people_partially_vaccinated"] ?? "Unknown"
                    self?.vaccinesDataValues = [result["administered"] ?? "Unknown"]
                    self?.vaccinesDataValues?.append(fullyVaccinated)
                    self?.vaccinesDataValues?.append(partiallyVaccinated)
                    // for charts view
                    self?.peopleFullyVaccinated = Int(fullyVaccinated)
                    self?.peoplePartiallyVaccinated = Int(partiallyVaccinated)
                    DispatchQueue.main.async {
                        self?.tableViewVaccination.reloadData()
                        self?.vaccinationSpinner.stopAnimating()
                        self?.vaccinationSpinner.hidesWhenStopped = true
                    }
                } else {
                    self?.showErrorAlert(for: error, spinner: self?.spinner)
                }
            }
        } else { return }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is CountryDetailMapViewController:
            let countryDetailMapViewController = segue.destination as? CountryDetailMapViewController
            countryDetailMapViewController?.lat = self.lat
            countryDetailMapViewController?.long = self.long
        case is ChartsViewController:
            let chartsViewController = segue.destination as? ChartsViewController
            chartsViewController?.casesConfirmed = self.casesConfirmed
            chartsViewController?.deaths = self.deaths
            chartsViewController?.population = self.population
            chartsViewController?.peopleFullyVaccinated = self.peopleFullyVaccinated
            chartsViewController?.peoplePartiallyVaccinated = self.peoplePartiallyVaccinated
        default:
            return
        }
    }
}
