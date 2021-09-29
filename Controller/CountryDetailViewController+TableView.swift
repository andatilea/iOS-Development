//
//  CountryDetailViewController+TableView.swift
//  Pandemify
//
//  Created by Anda Tilea on 02.09.2021.
//

import UIKit

extension CountryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewPrim {
            return countriesData.count
        } else {
            return vaccinesData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryDetailTableViewCell", for: indexPath)
                as? CountryDetailTableViewCell else {
            return CountryDetailTableViewCell()
        }
        // variables needed in order to create the gradient color
        cell.perLevel = CGFloat(1.0) / CGFloat(self.countriesData.count)
        cell.row = indexPath.row
        tableView.backgroundColor = colorHelper.determineColorCellAndTable(darkModeSwitch: nightMode)
        if tableView == tableViewPrim {
            guard countriesData.count > indexPath.row else {
                return cell
            }
            cell.setupCell(dataTitle: countriesData[indexPath.row],
                           dataValues: casesData?[indexPath.row] ?? "")
            return cell
        } else {
            guard vaccinesData.count > indexPath.row else {
                return cell
            }
            cell.setupCell(dataTitle: vaccinesData[indexPath.row],
                           dataValues: vaccinesDataValues?[indexPath.row] ?? "")
            return cell
        }
    }
}
