//
//  MapViewActionBotton.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showLocationSearchView:Bool
    var body: some View {
        Button {
            withAnimation(.spring) {
                self.showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left": "line.3.horizontal")
                .font(.title2)
                .foregroundColor(.black)
                .frame(width: 50,height: 50)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 3)
        }
        .frame(maxWidth: .infinity,alignment: .leading)

    }
}

#Preview {
    MapViewActionButton(showLocationSearchView: .constant(true))
}
