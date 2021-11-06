//
//  FloatingButton.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI

struct FloatingButton<Label: View>: View {
    let action: () -> Void
    let label: Label
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        Button(action: action) {
            label
                .font(Font.system(size: 20, weight: .bold))
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(action: {}) {
            Image(systemName: "plus")
                .frame(width: 40)
        }
    }
}
