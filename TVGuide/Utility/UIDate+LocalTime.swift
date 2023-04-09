//
//  UIDate+LocalTime.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/9/23.
//

import Foundation

extension Date {
    func convertToLocalTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcDateString = dateFormatter.string(from: self)
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: utcDateString)
    }
}
