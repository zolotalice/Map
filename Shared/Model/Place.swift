//
//  Place.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 05.07.2021.
//

import SwiftUI
import MapKit

struct Place: Identifiable{
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
