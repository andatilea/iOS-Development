//
//  ChartsViewController.swift
//  Pandemify
//
//  Created by Anda Tilea on 07.09.2021.
//

import UIKit
import Charts
class ChartsViewController: UIViewController, ChartViewDelegate {
    // iboutlets
    @IBOutlet weak var chartViewVaccination: BarChartView!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var casesStatisticsLabel: UILabel!
    @IBOutlet weak var vaccinationStatisticsLabel: UILabel!
    // data variables
    var chartXAxisCasesData: [String] = ["Confirmed Cases", "Deaths", "Population"]
    var chartXAxisVaccinationData: [String] = ["Fully Vaccinated", "Partially Vaccinated", "Population"]
    var casesConfirmed: Int?
    var deaths: Int?
    var population: Int?
    var peopleFullyVaccinated: Int?
    var peoplePartiallyVaccinated: Int?
    // variables needed for background
    let lightSetting = Settings()
    var nightMode: Bool = false
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        lightSetting.assignBackground(currentView: self.view, currentTitleLabel: nil)
        setupScreen()
        setupCasesData()
        setupVaccinationData()
        setupChart(chartView: self.chartView)
        setupChart(chartView: self.chartViewVaccination)
    }
    func setupScreen() {
        lightSetting.setupLabels(label: casesStatisticsLabel)
        lightSetting.setupLabels(label: vaccinationStatisticsLabel)
    }
    func setupDataEntries(dataEntries: BarChartDataSet, barChartView: BarChartView) {
        dataEntries.colors = [.brown, .brown, .brown]
        nightMode = defaults.bool(forKey: "nightMode")
        let chartData = BarChartData(dataSet: dataEntries)
        chartData.setDrawValues(true)
        if nightMode == true {
            chartData.setValueTextColor(.white)
        } else {
            chartData.setValueTextColor(.black)
        }
        guard let chartDataFont = UIFont(name: "HelveticaNeue-Medium", size: 15) else {return}
        chartData.setValueFont(chartDataFont)
        switch barChartView {
        case chartView:
            chartView.data = chartData
        case chartViewVaccination:
            chartViewVaccination.data = chartData
        default:
            return
        }
    }
    func setupCasesData() {
        let casesConfirmedEntry = BarChartDataEntry(x: 0, y: Double(casesConfirmed ?? 0))
        let deathsEntry = BarChartDataEntry(x: 1, y: Double(deaths ?? 0))
        let populationEntry = BarChartDataEntry(x: 2, y: Double(population ?? 0))
        let dataEntries = BarChartDataSet()
        dataEntries.append(casesConfirmedEntry)
        dataEntries.append(deathsEntry)
        dataEntries.append(populationEntry)
        setupDataEntries(dataEntries: dataEntries, barChartView: chartView)
    }
    func setupVaccinationData() {
        let fullyVaccinatedEntry = BarChartDataEntry(x: 0, y: Double(peopleFullyVaccinated ?? 0))
        let partiallyVaccinatedEntry = BarChartDataEntry(x: 1, y: Double(peoplePartiallyVaccinated ?? 0))
        let populationEntry = BarChartDataEntry(x: 2, y: Double(population ?? 0))
        let dataEntries = BarChartDataSet()
        dataEntries.append(fullyVaccinatedEntry)
        dataEntries.append(partiallyVaccinatedEntry)
        dataEntries.append(populationEntry)
        setupDataEntries(dataEntries: dataEntries, barChartView: chartViewVaccination)
    }
    func setupChart(chartView: BarChartView) {
        chartView.delegate = self
        // disable zoom function
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(false)
        chartView.doubleTapToZoomEnabled = false
        // Bar, Grid Line, Background
        chartView.drawBarShadowEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.drawBordersEnabled = false
        // Legend
        chartView.legend.enabled = false
        // Chart Offset
        chartView.setExtraOffsets(left: 10, top: 0, right: 20, bottom: 50)
        // Animation
        chartView.animate(yAxisDuration: 1.5, easingOption: .linear)
        // Setup X axis
        let xAxis = chartView.xAxis
        switch chartView {
        case self.chartView:
            xAxis.setLabelCount(chartXAxisCasesData.count, force: false)
            xAxis.valueFormatter = IndexAxisValueFormatter(values: chartXAxisCasesData)
            xAxis.axisMaximum = Double(chartXAxisCasesData.count)
        case self.chartViewVaccination:
            xAxis.setLabelCount(chartXAxisVaccinationData.count, force: false)
            xAxis.valueFormatter = IndexAxisValueFormatter(values: chartXAxisVaccinationData)
            xAxis.axisMaximum = Double(chartXAxisVaccinationData.count)
        default:
            return
        }
        // Setup left axis
        let leftAxis = chartView.leftAxis
        setChartColors(chartView: chartView)
        let leftAxisMaximum = Double(self.population ?? 0) * 1.1
        leftAxis.axisMaximum = leftAxisMaximum
        // Remove right axis
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
    }
    func setChartColors(chartView: BarChartView) {
        nightMode = defaults.bool(forKey: "nightMode")
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.labelRotationAngle = -20
        let leftAxis = chartView.leftAxis
        leftAxis.setLabelCount(12, force: true)
        leftAxis.axisMinimum = 0.0
        if nightMode == false {
            xAxis.axisLineColor = .brown
            xAxis.labelTextColor = .black
            leftAxis.axisLineColor = .brown
            leftAxis.labelTextColor = .black
        } else {
            xAxis.axisLineColor = .orange
            xAxis.labelTextColor = .orange
            leftAxis.axisLineColor = .orange
            leftAxis.labelTextColor = .orange
        }
        guard let chartXAxisFont = UIFont(name: "HelveticaNeue-Italic", size: 14) else {return}
        xAxis.labelFont = chartXAxisFont
    }
}
