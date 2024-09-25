//
//  MapViewActionBotton.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState:MapViewState
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .frame(width: 50,height: 50)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 3)
        }
        .frame(maxWidth: .infinity,alignment: .leading)

    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            print("No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
            vm.selectedLocationCoordinate = nil
        }
       
    }
    
    func imageNameForState(_ state: MapViewState ) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation , .locationSelected:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}
