//
//  HomeView.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState: MapViewState = .noInput
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        ZStack(alignment:.bottom) {
            ZStack(alignment:.top){
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput{
                    LocationSearchActivationView()
                        .padding(.top,72)
                        .onTapGesture {
                            withAnimation(.spring) {
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading,25)
                    .padding(.top,4)
            }
            
            if mapState == .locationSelected{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }.edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    vm.userLocation = location
                }
            }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
}
