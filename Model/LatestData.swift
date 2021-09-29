//
//  LatestData.swift
//  Pandemify
//
//  Created by Anda Tilea on 09.08.2021.
//

import Foundation
class LatestData {
    struct ResponseLatestData: Codable {
        let totalCases: String
        let activeCases: String
        let totalDeaths: String
        let totalRecovered: String
        let newDeaths: String
        let newCases: String
        let lastUpdate: String
        let country: String
        private enum CodingKeys: String, CodingKey {
            case totalCases = "Total Cases_text"
            case activeCases = "Active Cases_text"
            case totalDeaths = "Total Deaths_text"
            case totalRecovered = "Total Recovered_text"
            case newDeaths = "New Deaths_text"
            case newCases = "New Cases_text"
            case country = "Country_text"
            case lastUpdate = "Last Update"
        }
    }
    func arrayOfStrings(result: [LatestData.ResponseLatestData]) -> [String] {
        let stringArray: [String] = [result[0].totalCases,
                                     result[0].totalRecovered,
                                     result[0].totalDeaths,
                                     result[0].activeCases,
                                     result[0].newDeaths,
                                     result[0].newCases,
                                     result[0].lastUpdate]
        return stringArray
    }
}
