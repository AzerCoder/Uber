//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .cornerRadius(15)
                .shadow(color:.black ,radius: 3)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
