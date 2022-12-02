//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 26.11.2022.
//

import Foundation

extension Date {
    func toMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, YYYY"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
}
