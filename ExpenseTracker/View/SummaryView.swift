//
//  SummaryView.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI

struct SummaryView: View {
    let expenses: NSDecimalNumber
    let income: NSDecimalNumber
    
    private var balance: NSDecimalNumber {
        return income.subtracting(expenses)
    }
    
    private var progressVal: Double {
        guard !income.decimalValue.isZero else {
            return 0
        }
        
        return expenses.dividing(by: income).doubleValue
    }
    
    private func summaryView(title: String, amount: NSDecimalNumber) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .fontWeight(.semibold)
                .layoutPriority(2)
            Text(amount, formatter: NumberFormatter.currency)
        }
        .lineLimit(1)
        .frame(maxWidth: .infinity)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 15) {
                summaryView(title: "Expenses", amount: expenses)
                
                Divider()
                
                summaryView(title: "Income", amount: income)
                    .foregroundColor(.green)
                
                Divider()
                
                summaryView(title: "Balance", amount: balance)
                    .foregroundColor(balance.intValue < 0 ? .red : .blue)
            }
            .frame(maxWidth: .infinity)
            
            CustomProgressView(value: progressVal)
                .frame(height: 10)
        }
        .padding(.vertical)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(expenses: 2000, income: 1000)
            .border(Color.red)
            .frame(width: 300, height: 200)
    }
}
