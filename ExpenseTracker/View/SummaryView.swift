//
//  SummaryView.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI

struct SummaryView: View {
    let expenses: Int
    let income: Int
    
    private var balance: Int {
        return income - expenses
    }
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 15) {
                VStack(spacing: 8) {
                    Text("Expenses")
                        .fontWeight(.semibold)
                    Text(String.currency(from: expenses)!)
                }
                
                Divider()
                    .frame(height: 50)
                
                VStack(spacing: 8) {
                    Text("Income")
                        .fontWeight(.semibold)
                    Text(String.currency(from: income)!)
                }
                .foregroundColor(.green)
                
                Divider()
                    .frame(height: 50)
                
                VStack(spacing: 8) {
                    Text("Balance")
                        .fontWeight(.semibold)
                    Text(String.currency(from: balance)!)
                }
                .foregroundColor(balance < 0 ? .red : .black)
            }
                        
            CustomProgressView(value: 0.5)
                .frame(height: 10)
        }
        .padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(expenses: 2000, income: 1000)
            .border(Color.red)
            .frame(width: 300, height: 200)
    }
}
