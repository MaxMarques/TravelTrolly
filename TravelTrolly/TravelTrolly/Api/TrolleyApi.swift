//
//  TrolleyApi.swift
//  TravelTrolley
//
//  Created by Marques on 4/29/24.
//

import Foundation

class TrolleyApi: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var toastError: Bool = false
    @Published var CollinsExpressTrolley: GetTrolleyModels?
    @Published var NorthBeachLoopTrolley: GetTrolleyModels?
    @Published var MiddleBeachLoopTrolley: GetTrolleyModels?
    @Published var SouthBeachLoopATrolley: GetTrolleyModels?
    @Published var SouthBeachLoopBTrolley: GetTrolleyModels?

    func getCollinsExpressTrolley() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/siri/vehicle-monitoring?key=org.onebusaway.iphone&OperatorRef=2362&LineRef=33419&type=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyModels.self, from: data)
            self.isLoading = false
            self.CollinsExpressTrolley = response
            print("VV-Request Work: getCollinsExpressTrolley()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getCollinsExpressTrolley()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getCollinsExpressTrolley(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getNorthBeachLoopTrolley() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/siri/vehicle-monitoring?key=org.onebusaway.iphone&OperatorRef=2362&LineRef=33417&type=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyModels.self, from: data)
            self.isLoading = false
            self.NorthBeachLoopTrolley = response
            print("VV-Request Work: getNorthBeachLoopTrolley()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getNorthBeachLoopTrolley()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getNorthBeachLoopTrolley(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getMiddleBeachLoopTrolley() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/siri/vehicle-monitoring?key=org.onebusaway.iphone&OperatorRef=2362&LineRef=33418&type=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyModels.self, from: data)
            self.isLoading = false
            self.MiddleBeachLoopTrolley = response
            print("VV-Request Work: getMiddleBeachLoopTrolley()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getMiddleBeachLoopTrolley()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getMiddleBeachLoopTrolley(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getSouthBeachLoopATrolley() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/siri/vehicle-monitoring?key=org.onebusaway.iphone&OperatorRef=2362&LineRef=33422&type=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyModels.self, from: data)
            self.isLoading = false
            self.SouthBeachLoopATrolley = response
            print("VV-Request Work: getSouthBeachLoopATrolley()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getSouthBeachLoopATrolley()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getSouthBeachLoopATrolley(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
    
    func getSouthBeachLoopBTrolley() async throws {
        self.isLoading = true
        
        let url = URL(string: "https://comb.tracktrolley.com/oba-api-comb/siri/vehicle-monitoring?key=org.onebusaway.iphone&OperatorRef=2362&LineRef=67978&type=json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, _) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let response = try decoder.decode(GetTrolleyModels.self, from: data)
            self.isLoading = false
            self.SouthBeachLoopBTrolley = response
            print("VV-Request Work: getSouthBeachLoopBTrolley()-VV")
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                print("XX-Timeout error from the request: getSouthBeachLoopBTrolley()-XX")
                self.toastError = true
            } else {
                print("-XXError from the request: getSouthBeachLoopBTrolley(): \(error)-XX")
                self.isLoading = false
                self.toastError = true
                throw error
            }
        }
    }
}
