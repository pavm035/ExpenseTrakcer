//
//  TransactionsView.swift
//  ExpenseTracker
//

//

import SwiftUI

struct TransactionsView: View {
    @StateObject var viewModel = TranasactionViewModel(persistence: .preview)
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    SummaryView(expenses: viewModel.totalExpenses, income: viewModel.totalIncome)
                }

                ForEach(viewModel.transactionsInfo, id: \.title) { info in
                    Section {
                        ForEach(info.transactions) {
                            TransactionRow(transaction: $0)
                        }
                    } header: {
                        Text(info.title)
                    }
                }
            }
            .navigationTitle("Expense Tracker")
        }
        .onAppear {
            viewModel.load()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: .init(persistence: .preview))
    }
}
