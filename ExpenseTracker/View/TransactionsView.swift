//
//  TransactionsView.swift
//  ExpenseTracker
//

//

import SwiftUI

struct TransactionsView: View {
    @StateObject var viewModel = TranasactionViewModel(persistence: .shared)
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                List {
                    Section {
                        SummaryView(expenses: viewModel.totalExpenses, income: viewModel.totalIncome)
                    } header: {
                        Text("Summary")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .textCase(nil)
                    
                    ForEach(viewModel.transactionsInfo, id: \.title) { info in
                        Section {
                            ForEach(info.transactions) {
                                TransactionRow(transaction: $0)
                            }.onDelete { offsets in
                                withAnimation {
                                    viewModel.deleteItems(at: offsets, info: info)
                                }
                            }
                        } header: {
                            Text(info.transactions[0].timestamp!, style: .date)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black.opacity(0.6))
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
                FloatingButton {
                    viewModel.showNewTransaction = true
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 40)
                }
                .padding(.trailing, 10)
            }
            .navigationTitle("Expense Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(viewModel.transactionsInfo.isEmpty)
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
        .sheet(isPresented: $viewModel.showNewTransaction) {
            AddTransactionView(transactionViewModel: viewModel)
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(viewModel: .init(persistence: .preview))
    }
}
