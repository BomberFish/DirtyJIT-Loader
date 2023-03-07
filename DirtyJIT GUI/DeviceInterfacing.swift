//
//  DeviceInterfacing.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import Foundation

func getDevices() -> [iDevice] {
    print("Getting devices...")
    var i: CInt = 0
    var device_list: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>? = nil
    var devicenames: [iDevice] = []
    
    idevice_get_device_list(&device_list, &i)
    print("Number of devices: \(i)")
    
    let array = Array(UnsafeBufferPointer(start: device_list, count: Int(i)))
    
    for device in array {
        let uuid = String(cString: device!)
        
        var dev: idevice_t? = nil
        idevice_new_with_options(&dev, uuid, idevice_options(rawValue: 1 << 2))
        
        
        var lockdown: lockdownd_client_t? = nil
        lockdownd_client_new_with_handshake(dev, &lockdown, "idevicepair")
        
        var name: UnsafeMutablePointer<Int8>? = nil
        lockdownd_get_device_name(lockdown, &name);
        
        print (" - " + String(cString: name!))
        devicenames.append(iDevice(name: String(cString: name!), uuid: String(uuid)))
        
    }
    
    idevice_device_list_free(device_list)
    print(devicenames)
    return devicenames
}

struct iDevice: Identifiable, Equatable {
    /// make sure not to use `id` like ever
    var id = UUID()
    var name: String
    var uuid: String
}
