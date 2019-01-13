//
//  RideshareAnnotation.swift
//  RideshareList
//
//  Created by Karl Becker on 1/12/19.
//  Copyright © 2019 KB Productions, LLC. All rights reserved.
//

import Foundation
import MapKit

class RideshareAnnotation: NSObject, MKAnnotation {
    let service: RideshareService
    
    var coordinate: CLLocationCoordinate2D {
        let location = service.locations[0]
        return CLLocationCoordinate2D(latitude: location.lat , longitude: location.long)
    }
    
    init(service: RideshareService) {
        self.service = service
        super.init()
    }
    
    var  title:  String? {
        return service.name
    }
    
    var subtitle: String? {
        return service.locationDescription
    }
}
