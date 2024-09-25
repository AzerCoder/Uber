//
//  LocationSearchView.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 24/09/24.
//

import SwiftUI

struct LocationSearchView: View {
    @Binding var mapState:MapViewState
    @EnvironmentObject var vm : LocationSearchViewModel
    @State var startLocationText = ""
  
    var body: some View {
        VStack{
            //MARK: Header View
            
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6,height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 24)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6,height: 6)
                }
                
                
                VStack{
                    TextField("Current location", text: $startLocationText)
                        .padding(.leading)
                        .frame(height: 32)
                        .background(
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                        )
                        .cornerRadius(12)
                        .padding(.trailing)
                    TextField("Where to?", text: $vm.quaryFragment)
                        .padding(.leading)
                        .frame(height: 32)
                        .background(
                            Rectangle()
                                .fill(Color(.systemGray4))
                        )
                        .cornerRadius(12)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top,64)
            
            Divider()
            //MARK: List View
            
            ScrollView{
                VStack(alignment:.leading){
                    ForEach(vm.results,id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result
                            .subtitle)
                        .onTapGesture {
                            withAnimation(.spring) {
                                vm.selectLocation(result)
                                mapState = .locationSelected
                            }
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
        .environmentObject(LocationSearchViewModel())
}
