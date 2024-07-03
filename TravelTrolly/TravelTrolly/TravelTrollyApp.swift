//
//  TravelTrolleyApp.swift
//  TravelTrolley
//
//  Created by Marques on 4/16/24.
//

import SwiftUI

@main
struct TravelTrolleyApp: App {

    @StateObject var trolleyRoutesApi = TrolleyRoutesApi()
    @StateObject var trolleyApi = TrolleyApi()

    var body: some Scene {
        WindowGroup {
            LaunchComponent()
                .environmentObject(trolleyRoutesApi)
                .environmentObject(trolleyApi)
                .onAppear{
                    Task {
                        try await self.trolleyRoutesApi.getCollinsExpressRoute()
                        try await self.trolleyRoutesApi.getNorthBeachLoopRoute()
                        try await self.trolleyRoutesApi.getMiddleBeachLoopRoute()
                        try await self.trolleyRoutesApi.getSouthBeachLoopARoute()
                        try await self.trolleyRoutesApi.getSouthBeachLoopBRoute()
                        try await self.trolleyApi.getCollinsExpressTrolley()
                        try await self.trolleyApi.getNorthBeachLoopTrolley()
                        try await self.trolleyApi.getMiddleBeachLoopTrolley()
                        try await self.trolleyApi.getSouthBeachLoopATrolley()
                        try await self.trolleyApi.getSouthBeachLoopBTrolley()
                    }
                }
        }
    }
}
