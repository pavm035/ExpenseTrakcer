//
//  String+Extension.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.minimumFractionDigits = 0
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en-US")
        return currencyFormatter
    }()
}
