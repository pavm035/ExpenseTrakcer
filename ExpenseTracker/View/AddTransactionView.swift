//
//  AddTransactionView.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dimiss
    @ObservedObject var transactionViewModel: TranasactionViewModel
    @StateObject private var viewModel = AddTransactionViewModel(persistence: .shared)
    
    private var transactionTypeView: some View {
        DisclosureGroup("Transaction Type", isExpanded: $viewModel.transactionTypeExpanded) {
            ForEach(viewModel.transactionTypes, id: \.self) { type in
                Button {
                    viewModel.selectedTransactionType = type
                } label: {
                    HStack {
                        Text(type.displayString)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .opacity(viewModel.selectedTransactionType == type ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var descriptionView: some View {
        TextField("Description", text: $viewModel.description)
            .foregroundColor(.blue)
            .font(Font.system(size: 17, weight: .medium))
    }
    
    private var currencyView: some View {
        HStack {
            Text("Amount")
            Spacer()
            TextField("", value: $viewModel.currency, format: .currency(code: "USD"))
                .padding(.leading, 5)
                .frame(width: 100, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.blue)
                )
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    descriptionView
                    transactionTypeView
                    currencyView
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dimiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.save()
                        dimiss()
                    }
                    .disabled(!viewModel.enableSave)
                }
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(transactionViewModel: TranasactionViewModel(persistence: .shared))
    }
}
