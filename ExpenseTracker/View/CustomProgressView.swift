//
//  CustomProgressView.swift
//  ExpenseTracker
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2021/11/06.
//

import SwiftUI


struct CustomProgressView: View {
    let value: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.accentColor.opacity(0.1))
                
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: proxy.size.width * value)
            }
        }
    }
}


struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(value: 20)
            .frame(height: 20)
    }
}
