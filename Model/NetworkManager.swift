//
//  NetworkManager.swift
//  Pandemify
//
//  Created by Anda Tilea on 09.08.2021.
//

import Foundation

class NetworkManager {
    let latestData = LatestData()
    let countryAbv = CountryListAbv()
    func fetchLatestData(completionHandler: @escaping ([String], Error?) -> Void) {
        let urlString = DataURLStrings.latestDataUrlString
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching data: \(error)")
                completionHandler([], error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completionHandler([], error)
                return
            }
            if let data = data,
               let result = try? JSONDecoder().decode(LatestData.ResponseLatestData.self, from: data) {
                let dataStrings = self.latestData.arrayOfStrings(result: [result])
                completionHandler(dataStrings, error)
            }
        })
        task.resume()
    }
    func fetchCountryListData(completionHandler: @escaping ([String], [String], Error?) -> Void) {
        var countriesData: [String] = [""]
        var abbreviationData: [String] = [""]
        let urlString = DataURLStrings.countryListUrlStirng
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil || data == nil {
                print("Error with fetching data: \(String(describing: error))")
                completionHandler([], [], error)
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completionHandler([], [], error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String: NSDictionary] {
                    // json is a dictionary
                    for (key, value) in object {
                        countriesData.append(key)
                        // abbreviation set up
                        abbreviationData.append(self.setupAbbreviation(value: value))
                    }
                    // remove any empty elements
                    countriesData = countriesData.filter { !$0.isEmpty }
                    abbreviationData = abbreviationData.filter { !$0.isEmpty }
                    // creating a single array and sort it accordingly
                    let combined = zip(countriesData, abbreviationData).sorted { $0.0 < $1.0 }
                    let resultCountriesData = combined.map {$0.0}
                    let resultAbbreviationData = combined.map {$0.1}
                    // send the results
                    completionHandler(resultCountriesData, resultAbbreviationData, error)
                } else {
                    print("JSON is invalid")
                    completionHandler([], [], error)
                }
            } catch {
                print(error.localizedDescription)
                completionHandler([], [], error)
            }
        })
        task.resume()
    }
    func setupAbbreviation(value: NSDictionary) -> String {
        let final = value.value(forKey: "All") as? [String: Any]
        guard let result = (final?["abbreviation"]) else {
            return "-"
        }
        return result as? String ?? ""
    }
    func setupCompletionHandler(urlString: String,
                                completionHandler:@escaping ([String: String], Error?) -> Void,
                                data: Data?, response: URLResponse?, error: Error?) {
        if error != nil || data == nil {
            print("Error with fetching data: \(String(describing: error))")
            completionHandler([:], error)
            return
        }
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            completionHandler([:], error)
            return
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            if let object = json as? [String: NSDictionary] {
                // json is a dictionary
                guard let data = (object["All"] ?? [:]) as? [String: Any] else {
                    return
                }
                var result: [String: String] = [:]
                let urlStringCases = DataURLStrings.countryListUrlStirng
                let urlStringVaccination = DataURLStrings.countryListVaccinesUrlString
                if urlString == urlStringCases {
                    result["confirmed"] =  String(describing: data["confirmed"] ?? "Unknown")
                    result["deaths"] = String(describing: data["deaths"] ?? "Unknown")
                    result["updated"] = data["updated"] as? String ?? "Unknown"
                    result["lat"] = data["lat"] as? String ?? ""
                    result["long"] = data["long"] as? String ?? ""
                    result["population"] = String(describing: data["population"] ?? "Unknown")
                    // send the results
                    completionHandler(result, error)
                } else if urlString == urlStringVaccination {
                    result["administered"] =  String(describing: data["administered"] ?? "Unknown")
                    result["people_vaccinated"] = String(describing: data["people_vaccinated"] ?? "Unknown")
                    result["people_partially_vaccinated"] = String(describing:
                                                                    data["people_partially_vaccinated"] ?? "Unknown")
                    // send the results
                    completionHandler(result, error)
                }
            } else {
                print("JSON is invalid")
                completionHandler([:], error)
            }
        } catch {
            print(error.localizedDescription)
            completionHandler([:], error)
        }
    }
    func fetchCountryDetailsCasesData(countryName: String,
                                      completionHandler: @escaping ([String: String], Error?) -> Void) {
        let urlStringCases = DataURLStrings.countryListUrlStirng
        guard let url = URL(string: self.setupUrl(urlString: urlStringCases, countryName: countryName)) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.setupCompletionHandler(urlString: urlStringCases,
                                        completionHandler: completionHandler,
                                        data: data, response: response, error: error)
        })
        task.resume()
    }
    func fetchCountryDetailsVaccinesData(countryName: String,
                                         completionHandler: @escaping ([String: String], Error?) -> Void) {
        let urlStringVaccination = DataURLStrings.countryListVaccinesUrlString
        guard let url = URL(string: self.setupUrl(urlString: urlStringVaccination,
                                                  countryName: countryName)) else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.setupCompletionHandler(urlString: urlStringVaccination,
                                        completionHandler: completionHandler,
                                        data: data, response: response, error: error)
        })
        task.resume()
    }
    func setupUrl(urlString: String, countryName: String) -> String {
        var stringToUse = urlString
        let encodedCountryName = countryName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        stringToUse.append("?country=\(encodedCountryName)")
        return stringToUse
    }
}
