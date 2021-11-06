//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI
import CoreData

struct TransactionRow: View {
    let transaction: Transaction
    
    private var currency: String {
        let currency = String.currency(from: transaction.currency!.intValue)!
        return transaction.transactionType == .expense ? ("- " + currency) : currency
    }
    
    private var currencyColor: Color {
        return transaction.transactionType == .expense ? .red : .green
    }
    
    var body: some View {
        HStack {
            Text(transaction.name!)
                .fontWeight(.semibold)
            
            Spacer(minLength: 0)
            
            Text(currency)
                .foregroundColor(currencyColor)
                .fontWeight(.semibold)
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static private var testTransaction: Transaction {
        let transaction = Transaction(context: PersistenceController.preview.container.viewContext)
        transaction.name = "Salary"
        transaction.currency = NSDecimalNumber(value: 1000)
        transaction.timestamp = Date()
        transaction.type = 1
        return transaction
    }
    
    static var previews: some View {
        return TransactionRow(transaction: testTransaction)
    }
}
