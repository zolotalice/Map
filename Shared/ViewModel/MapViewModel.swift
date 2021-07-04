//
//  MapViewModel.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 04.07.2021.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var mapView = MKMapView()
    //region
    @Published var region: MKCoordinateRegion!
    //based on location it will set up
    
    //alert
    @Published var permissionDenied = false
    
    //map type
    @Published var mapType: MKMapType = .standard
    
    //update map type
    
    func updateMapType(){
        if mapType == .standard{
            mapType = .satellite
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // focus location
    
    func focusLocation(){
        guard let _ = region else{return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // checking permissions
        
        switch manager.authorizationStatus{
            
            case .denied:
                permissionDenied.toggle()
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                //if permission given
                manager.requestLocation()
            default:
                ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // getins user region
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        //Updating map
        self.mapView.setRegion(self.region, animated: true)
        
        // smooth animations
        
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
