//
//  MainView.swift
//  TravelTrolley
//
//  Created by Marques on 4/16/24.
//

import SwiftUI
import MapKit

struct MainView: View {
    
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var trolleyRoutesApi: TrolleyRoutesApi
    @EnvironmentObject var trolleyApi: TrolleyApi

    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            MapComponent()
                .ignoresSafeArea(.all)
                .environmentObject(locationManager)
                .environmentObject(trolleyRoutesApi)
                .environmentObject(trolleyApi)
            VStack {
                carouselSelectorComponent()
                    .environmentObject(locationManager)
                
                CenterLocationComponent()
                    .environmentObject(locationManager)
            }
        }
        .onReceive(timer) { _ in
            Task {
                do {
                    switch locationManager.trolleyRoutes {
                    case "Collins Express":
                        try await self.trolleyApi.getCollinsExpressTrolley()
                    case "North Beach Loop":
                        try await self.trolleyApi.getNorthBeachLoopTrolley()
                    case "Middle Beach Loop":
                        try await self.trolleyApi.getMiddleBeachLoopTrolley()
                    case "South Beach Loop A":
                        try await self.trolleyApi.getSouthBeachLoopATrolley()
                    case "South Beach Loop B":
                        try await self.trolleyApi.getSouthBeachLoopBTrolley()
                    default:
                        break
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
