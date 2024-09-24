//
//  HomeView.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct HomeView: View {
    @State var showLocationSearchView = false
    var body: some View {
        ZStack(alignment:.top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
                   // .transition(.move(edge: .bottom))
            } else {
                LocationSearchActivationView()
                    .padding(.top,72)
                    .onTapGesture {
                        withAnimation(.spring) {
                            showLocationSearchView = true
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading,25)
                .padding(.top,4)
        }
    }
}

#Preview {
    HomeView()
}
