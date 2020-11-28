//
//  HolidayManager.swift
//  Holidays
//
//  Created by Анастасия Улитина on 28.11.2020.
//

import Foundation

struct HolidayManager {
    
    enum HolidayError: Error {
        case noDataAvilable
        case canNotProcessData
    }
    
    let resourceUrl: URL
    
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        let resourcceString = "https://calendarific.com/api/v2/holidays?&\(ApiKey.apiKey)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceUrl = URL(string: resourcceString) else {fatalError("Cannot create url")}
        self.resourceUrl = resourceUrl
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: resourceUrl) { (data, respone, error) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvilable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(HolidayData.self, from: jsonData)
                let holidayDetails = decodedData.response.holidays
                //print(holidayDetails)
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
