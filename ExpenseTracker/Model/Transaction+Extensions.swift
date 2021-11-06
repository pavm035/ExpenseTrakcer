//
//  TransactionType.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import Foundation

enum TransactionType: Int32, CaseIterable {
    case expense
    case income
    
    var displayString: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }
}

// MARK: - Transaction + Extension
extension Transaction {
    var transactionType: TransactionType {
        TransactionType(rawValue: type)!
    }
    
    @objc var isoDate: String { get {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        // insert settings for TimeZone and Calendar here
        return formatter.string(from: timestamp!)
    }}
}
