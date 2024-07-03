//
//  GetTrolleyModels.swift
//  TravelTrolley
//
//  Created by Marques on 4/29/24.
//

import Foundation

struct GetTrolleyModels: Codable {
    let Siri: SiriData
}

struct SiriData: Codable {
    let ServiceDelivery: ServiceDeliveryData
}

struct ServiceDeliveryData: Codable {
    let ResponseTimestamp: String
    let VehicleMonitoringDelivery: [VehicleMonitoringDeliveryData]
}

struct VehicleMonitoringDeliveryData: Codable {
    let VehicleActivity: [VehicleActivityData]
    let ResponseTimestamp: String
    let ValidUntil: String
}

struct VehicleActivityData: Codable {
    let MonitoredVehicleJourney: MonitoredVehicleJourneyData
    let RecordedAtTime: String
}

struct MonitoredVehicleJourneyData: Codable {
    let LineRef: String
    let DirectionRef: String
    let FramedVehicleJourneyRef: FramedVehicleJourneyRefData
    let JourneyPatternRef: String
    let VehicleMode: [String]
    let PublishedLineName: String
    let OperatorRef: String
    let OriginRef: String
    let DestinationRef: String
    let DestinationName: String
    let SituationRef: [String]
    let Monitored: Bool
    let VehicleLocation: VehicleLocationData
    let Bearing: Double
    let ProgressRate: String
    let BlockRef: String
    let VehicleRef: String
    let MonitoredCall: MonitoredCallData
    let OnwardCalls: [String: String]
}

struct FramedVehicleJourneyRefData: Codable {
    let DataFrameRef: String
    let DatedVehicleJourneyRef: String
}

struct VehicleLocationData: Codable {
    let Longitude: Double
    let Latitude: Double
}

struct MonitoredCallData: Codable {
    let AimedArrivalTime: String
    let ExpectedArrivalTime: String
    let ExpectedDepartureTime: String
    let Extensions: ExtensionsData
    let StopPointRef: String
    let VisitNumber: Int
    let StopPointName: String
}

struct ExtensionsData: Codable {
    let Distances: DistancesData
    let Deviation: String
}

struct DistancesData: Codable {
    let CallDistanceAlongRoute: Double
    let PresentableDistance: String
    let DistanceFromCall: Double
    let StopsFromCall: Int
}
