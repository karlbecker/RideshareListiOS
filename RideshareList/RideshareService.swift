//
//  RideshareService.swift
//  RideshareList
//
//  Created by Karl Becker on 1/12/19.
//  Copyright © 2019 KB Productions, LLC. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

enum AppPlatform : String, Codable {
    case ios
    case android
}

struct App: Codable {
    let platform: AppPlatform
    let url: URL
}

struct ContactInfo:  Codable {
    let email: String?
    let phone: String?
}

struct ServiceLocation: Codable {
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    let radiusInMiles: Float    
}

struct RideshareService: Codable {
    let name: String
    let url: URL
    let description: String
    let locationDescription: String
    let locations: [ServiceLocation]
    let apps: [App]
    let contact: ContactInfo
}
