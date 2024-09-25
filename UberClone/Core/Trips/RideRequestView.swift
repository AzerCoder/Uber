//
//  RideRequestView.swift
//  UberClone
//
//  Created by A'zamjon Abdumuxtorov on 25/09/24.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType : RideType = .uberX
    @EnvironmentObject var vm: LocationSearchViewModel
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
                .padding(.top,8)
            
            // trip info view
            HStack{
                // indicator view
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8,height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 32)
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 8,height: 8)
                }
                
                VStack(alignment:.leading,spacing: 24) {
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        
                        Text("1:30 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }.padding(.bottom,10)
                    
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16,weight: .semibold))

                        Spacer()
                        
                        Text("1:45 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading,8)
                
            }.padding()
            
            Divider()
            
            // ride type selection view
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity,alignment: .leading)
            
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing:12){
                    ForEach(RideType.allCases){ item in
                        VStack(alignment:.leading){
                            Image(systemName: item.imageName)
                                .resizable()
                                .scaledToFit()
                                .padding(8)
                                .foregroundColor(.black)
                            
                            VStack(alignment:.leading,spacing: 4){
                                Text(item.description)
                                    .font(.system(size: 14,weight: .semibold))
                                
                                Text(vm.computeRidePrice(forType: item).toCurrency())
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            .padding(8)
                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(selectedRideType == item ? .white : .black)
                        .background(Color(selectedRideType == item ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(selectedRideType == item ? 1.1 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring) {
                                selectedRideType = item
                            }
                        }
                    }
                }
               
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical,4)
            // payment option view
            
            HStack(spacing:12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            // request ride button
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame( width: UIScreen.main.bounds.width - 32 ,height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

        }
        .padding(.bottom,40)
        .background(.white)
        .cornerRadius(30)
    }
}

#Preview {
    RideRequestView()
        .environmentObject(LocationSearchViewModel())
}
