//
//  AddTransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import Foundation

class AddTransactionViewModel: ObservableObject {
    let persistence: PersistenceController
    let transactionTypes = TransactionType.allCases
    
    @Published var enableSave = false
    @Published var transactionTypeExpanded = true
    @Published var description = "" {
        didSet {
            updateSaveStatus()
        }
    }
    @Published var selectedTransactionType: TransactionType = .expense {
        didSet {
            updateSaveStatus()
        }
    }
    @Published var currency = 0 {
        didSet {
            updateSaveStatus()
        }
    }
    
    init(persistence: PersistenceController) {
        self.persistence = persistence
    }
        
    func save() {
        let transaction = Transaction(context: persistence.container.viewContext)
        transaction.type = selectedTransactionType.rawValue
        transaction.name = description
        transaction.currency = NSDecimalNumber(value: currency)
        
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = -2

        let pastDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        transaction.timestamp = pastDate //Date()
        persistence.container.viewContext.insert(transaction)
        persistence.save()
    }
    
    private func updateSaveStatus() {
        enableSave = !description.isEmpty && currency != 0
    }
}
