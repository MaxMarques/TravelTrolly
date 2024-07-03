//
//  CenterLocationComponent.swift
//  TravelTrolley
//
//  Created by Marques on 4/18/24.
//

import SwiftUI

struct CenterLocationComponent: View {
    
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        locationManager.centerLocation.toggle()
                    }) {
                        Image(systemName: "location.fill")
                            .foregroundColor(Color("text-3"))
                            .padding()
                            .background(Color("background-2").opacity(0.95))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                    }
                    .padding()

                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CenterLocationComponent()
}
