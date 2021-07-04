//
//  Home.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 04.07.2021.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    
    // Location Manager
    @State var locationManager = CLLocationManager()
    var body: some View {
        ZStack{
            MapView()
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                Spacer()
                VStack{
                    Button(action: {}, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    
                    Button(action: {mapData.updateMapType()}, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .onAppear(perform: {
            //Setting delegate
            locationManager.delegate = mapData
            locationManager.requestWhenInUseAuthorization()
        })
        // Permission Denied Alert
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Setings"), dismissButton: .default(Text("Go to settings"), action: {
                // redirecting user to settings
                
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
            
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
