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
    @Published private(set) var totalExpenses: Int =  0
    @Published private(set) var totalIncome: Int =  0

    
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
    
    private func updateFetchedInfo() {
        self.transactionsInfo = fetchController.sections?.compactMap{ sectionInfo in
            guard let transactions = sectionInfo.objects as? [Transaction] else {
                return nil
            }
            return (sectionInfo.name, transactions)
        } ?? []
        
        fetchController.fetchedObjects?.forEach({ [weak self] transaction in
            guard let self = self else { return }
            
            if transaction.transactionType == .income {
                self.totalIncome += transaction.currency?.intValue ?? 0
            } else {
                self.totalExpenses += transaction.currency?.intValue ?? 0
            }
        })
    }
}

extension TranasactionViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateFetchedInfo()
    }
}
