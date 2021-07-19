//
//  MapView.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 04.07.2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        func mapView(_ mapView:MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            //custom pins
            
            if annotation.isKind(of: MKUserLocation.self){return nil}
                else{
                    let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                    pinAnnotation.tintColor = .red
                    pinAnnotation.animatesDrop = true
                    pinAnnotation.canShowCallout = true
                    
//                    let btn = UIButton(type: .detailDisclosure)
//                    let btn = UIButton(type: <#T##UIButton.ButtonType#>, primaryAction: UIAction?)
//                    pinAnnotation.rightCalloutAccessoryView = btn
                    
                    return pinAnnotation
                }
            }
        }
    }



