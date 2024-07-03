//
//  TrolleyApi.swift
//  TravelTrolley
//
//  Created by Marques on 4/22/24.
//

import Foundation

class TrolleyRoutesApi: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var toastError: Bool = false
    @Published var CollinsExpressRoute: GetTrolleyRoutesModels?
    @Published var NorthBeachLoopRoute: GetTrolleyRoutesModels?
    @Published var MiddleBeachLoopRoute: GetTrolleyRoutesModels?
    @Published var SouthBeachLoopARoute: GetTrolleyRoutesModels?
    @Published var SouthBeachLoopBRoute: GetTrolleyRoutesModels?
    
    func getCollinsExpressRoute() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/api/where/stops-for-route/2362_33419.json?key=org.onebusaway.iphone&includePolylines=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyRoutesModels.self, from: data)
            self.isLoading = false
            self.CollinsExpressRoute = response
            print("VV-Request Work: getCollinsExpressRoute()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getCollinsExpressRoute()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getCollinsExpressRoute(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getNorthBeachLoopRoute() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/api/where/stops-for-route/2362_33417.json?key=org.onebusaway.iphone&includePolylines=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyRoutesModels.self, from: data)
            self.isLoading = false
            self.NorthBeachLoopRoute = response
            print("VV-Request Work: getNorthBeachLoopRoute()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getNorthBeachLoopRoute()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getNorthBeachLoopRoute(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getMiddleBeachLoopRoute() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/api/where/stops-for-route/2362_33418.json?key=org.onebusaway.iphone&includePolylines=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyRoutesModels.self, from: data)
            self.isLoading = false
            self.MiddleBeachLoopRoute = response
            print("VV-Request Work: getMiddleBeachLoopRoute()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getMiddleBeachLoopRoute()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getMiddleBeachLoopRoute(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getSouthBeachLoopARoute() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/api/where/stops-for-route/2362_33422.json?key=org.onebusaway.iphone&includePolylines=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyRoutesModels.self, from: data)
            self.isLoading = false
            self.SouthBeachLoopARoute = response
            print("VV-Request Work: getSouthBeachLoopARoute()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getSouthBeachLoopARoute()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getSouthBeachLoopARoute(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getSouthBeachLoopBRoute() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/api/where/stops-for-route/2362_67978.json?key=org.onebusaway.iphone&includePolylines=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyRoutesModels.self, from: data)
            self.isLoading = false
            self.SouthBeachLoopBRoute = response
            print("VV-Request Work: getSouthBeachLoopBRoute()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getSouthBeachLoopBRoute()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getSouthBeachLoopBRoute(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
}
