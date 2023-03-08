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
    let unknownName: UnsafeMutablePointer<Int8> =  stringToUnsafeUint8(string: "Unknown")
    
    idevice_get_device_list(&device_list, &i)
    print("Number of devices: \(i)")
    
    let array = Array(UnsafeBufferPointer(start: device_list, count: Int(i)))
    
    for device in array {
        let uuid = String(cString: device!)
        
        var dev: idevice_t? = nil
        print("Initializing new iDevice...")
        idevice_new_with_options(&dev, uuid, idevice_options(rawValue: 1 << 2))
        
        
        var lockdown: lockdownd_client_t? = nil
        print("Initializing lockdownd client...")
        lockdownd_client_new_with_handshake(dev, &lockdown, "DirtyJIT")
        
        var name: UnsafeMutablePointer<Int8>? = nil
        print("Getting device name...")
        lockdownd_get_device_name(lockdown, &name);
        
        var afc_client: afc_client_t? = nil
        afc_client_start_service(dev, &afc_client, "DirtyJIT")
        
        // TODO: Device type
        var device_info: UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?>? = nil
        // afc_get_device_info(afc_client, &device_info)
        // print(device_info as Any)
        
        // print (" - " + String(cString: name ?? unknownName))
        devicenames.append(iDevice(name: String(cString: name ?? unknownName), uuid: String(uuid)))
        
    }
    
    idevice_device_list_free(device_list)
    // print(devicenames)
    return devicenames
}

func stringToUnsafeUint8(string: String) -> UnsafeMutablePointer<Int8> {
    let cs = (string as NSString).utf8String
    let buffer = UnsafeMutablePointer<Int8>(mutating: cs)
    return buffer!
}



struct iDevice: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var uuid: String
}
