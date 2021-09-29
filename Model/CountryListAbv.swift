//
//  CountryListAbv.swift
//  Pandemify
//
//  Created by Anda Tilea on 30.08.2021.
//

import Foundation
class CountryListAbv {
    struct ResponseCountryList: Codable {
        let abbreviation: String
        let capital: String
        let confirmed: Int
        let continent: String
        let country: String
        let deaths: Int
        let elevation: Int
        let iso: Int
        let lat: String
        let lifeExpectancy: String
        let location: String
        let long: String
        let population: Int
        let recovered: Int
        let kmArea: Int
        let updated: String
        private enum CodingKeys: String, CodingKey {
            case abbreviation
            case capital = "capital_city"
            case confirmed, continent, country, deaths
            case elevation = "elevation_in_meters"
            case iso, lat
            case lifeExpectancy = "life_expectancy"
            case location, long, population, recovered
            case kmArea = "sq_km_area"
            case updated
        }
    }
    func arrayOfStrings(result: [CountryListAbv.ResponseCountryList]) -> [String] {
        let stringArray: [String] = [result[0].abbreviation]
        return stringArray
    }
}
