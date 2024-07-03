//
//  GetRoutesModels.swift
//  TravelTrolley
//
//  Created by Marques on 4/22/24.
//

import Foundation

struct GetTrolleyRoutesModels: Codable {
    let code: Int
    let currentTime: Int
    let data: DataObject
    let text: String
    let version: Int
}

struct Polyline: Codable {
    let length: Int
    let levels: String
    let points: String
}

struct StopGroup: Codable {
    let id: String
    let name: Name
    let polylines: [Polyline]
    let stopIds: [String]
    let subGroups: [String]
}

struct AgencyReference: Codable {
    let disclaimer: String
    let email: String
    let fareUrl: String
    let id: String
    let lang: String
    let name: String
    let phone: String
    let privateService: Bool
    let timezone: String
    let url: String
}

struct Route: Codable {
    let agencyId: String
    let color: String
    let description: String
    let id: String
    let longName: String
    let shortName: String
    let textColor: String
    let type: Int
    let url: String
}

struct DataObject: Codable {
    let entry: Entry
    let references: References
}

struct Entry: Codable {
    let polylines: [Polyline]
    let routeId: String
    let stopGroupings: [StopGrouping]
    let stopIds: [String]
}

struct StopGrouping: Codable {
    let ordered: Bool
    let stopGroups: [StopGroup]
    let type: String
}

struct References: Codable {
    let agencies: [AgencyReference]
    let routes: [Route]
    let stops: [Stops]
}

struct Name: Codable {
    let name: String
    let names: [String]
    let type: String
}

struct Stops: Codable {
    let code: String
    let direction: String
    let id: String
    let lat: Double
    let locationType: Int
    let lon: Double
    let name: String
    let routeIds: [String]
    let wheelchairBoarding: String
}
