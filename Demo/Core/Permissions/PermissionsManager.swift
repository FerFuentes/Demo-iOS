//
//  permissionsManager.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import CoreLocation

enum LocationStatus {
    case whenInUse
    case notDetermined
    case always
    case denied
}

class PermissionsManager: NSObject, CLLocationManagerDelegate {
    @Published private(set) var locationPermissionStatus: LocationStatus = .notDetermined
    

    static let shared = PermissionsManager()
    
    private var locationManager = CLLocationManager()
    
    var isPermissionGranted: Bool {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            return true
        default:
            return false
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    private func checkSAuthorizationStatus() -> Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse:
            locationPermissionStatus = .whenInUse
            
        case .notDetermined:
            locationPermissionStatus = .notDetermined
            
        case .authorizedAlways:
            locationPermissionStatus = .always
            
        default:
            locationPermissionStatus = .denied
        }
    }

}
