//
//  HolidayData.swift
//  Holidays
//
//  Created by Анастасия Улитина on 28.11.2020.
//

import Foundation

struct HolidayData: Decodable {
    let response: Holidays
}

struct Holidays: Decodable {
    let holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    let name: String
    let date: DateInfo
}

struct DateInfo: Decodable {
    let iso: String
}
