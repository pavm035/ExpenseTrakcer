//
//  TranasactionViewModel.swift
//  ExpenseTracker
//

//

import Foundation
import CoreData

typealias TransactionInfo = (title: String, transactions: [Transaction])
class TranasactionViewModel: NSObject, ObservableObject {
    
    let persistence: PersistenceController
    private var fetchController: NSFetchedResultsController<Transaction>
    @Published private(set) var transactionsInfo: [TransactionInfo] = []
    @Published private(set) var transactionsInfo1: [(Int, Int)] = []
    @Published private(set) var totalExpenses: NSDecimalNumber =  0
    @Published private(set) var totalIncome: NSDecimalNumber =  0
    @Published var showNewTransaction = false
    
    
    init(persistence: PersistenceController) {
        self.persistence = persistence
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)]
        fetchController = NSFetchedResultsController(fetchRequest: request,
                                                     managedObjectContext: persistence.container.viewContext,
                                                     sectionNameKeyPath: "isoDate",
                                                     cacheName: nil)
        super.init()
        fetchController.delegate = self
    }
    
    func load() {
        do {
            try fetchController.performFetch()
            updateFetchedInfo()
        } catch {
            debugPrint("failed to fetch items!", error)
        }
    }
    
    func deleteItems(at offsets: IndexSet, info: TransactionInfo) {
        persistence.delete(objects: offsets.map { info.transactions[$0] })
        debugPrint("deleted items")
    }
    
    private func updateFetchedInfo() {
        self.transactionsInfo = fetchController.sections?.compactMap{ sectionInfo in
            guard let transactions = sectionInfo.objects as? [Transaction] else {
                return nil
            }
            return (sectionInfo.name, transactions)
        } ?? []
        
        var income = 0
        var expenses = 0
        fetchController.fetchedObjects?.forEach { transaction in
            if transaction.transactionType == .income {
                income += transaction.currency?.intValue ?? 0
            } else {
                expenses += transaction.currency?.intValue ?? 0
            }
        }
        
        totalIncome = NSDecimalNumber(value: income)
        totalExpenses = NSDecimalNumber(value: expenses)
    }
}

extension TranasactionViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateFetchedInfo()
    }
}
