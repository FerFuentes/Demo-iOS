//
//  Core.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import Combine
import Foundation

protocol Core {
    var isPermisionGranted: Bool { get }
    var locationPermissionStatus: Published<LocationStatus>.Publisher { get }
    func requestPermission()
}


extension Core {
    
    var locationPermissionStatus: Published<LocationStatus>.Publisher {
        PermissionsManager.shared.$locationPermissionStatus
    }
    
    var isPermisionGranted: Bool  {
        checkPermission()
    }
    
    func requestPermission() {
        let permissionsManager = PermissionsManager.shared
        permissionsManager.requestLocationPermission()
    }
    
    private func checkPermission() -> Bool {
        let permissionsManager = PermissionsManager.shared
        return permissionsManager.isPermissionGranted
    }
    
}
