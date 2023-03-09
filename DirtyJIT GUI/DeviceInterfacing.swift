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
        // var device_info: UnsafeMutablePointer<UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?>? = nil
        // afc_get_device_info(afc_client, &device_info)
        // print(device_info as Any)
        
        // print (" - " + String(cString: name ?? unknownName))
        devicenames.append(iDevice(name: String(cString: name ?? unknownName), uuid: String(uuid)))
        
    }
    
    idevice_device_list_free(device_list)
    // print(devicenames)
    return devicenames
}

func mountImage(uuid: String, imagePath: String, signaturePath: String) {
    print("Mounting image \(imagePath) with signature \(signaturePath)...")
    print("Initializing iDevice...")
    var dev: idevice_t? = nil
    idevice_new_with_options(&dev, uuid, idevice_options(rawValue: 1 << 2))
    print("Initializing mobile_image_mounter client...")
    var mimclient: mobile_image_mounter_client_t? = nil
    mobile_image_mounter_start_service(dev, &mimclient, "DirtyJIT")
    print("Uploading image...")
    var dmgSize: Int? = nil
    var sigSize: UInt16? = nil
    
    dmgSize = getFileSizeAsInt(path: imagePath)
    sigSize = getFileSizeAsUInt16(path: signaturePath)
    
    mobile_image_mounter_upload_image(mimclient, "Developer", dmgSize!, fileToUnsafeCchar(path: signaturePath), sigSize!, <#T##upload_cb: mobile_image_mounter_upload_cb_t!##mobile_image_mounter_upload_cb_t?##(UnsafeMutableRawPointer?, Int, UnsafeMutableRawPointer?) -> Int#>, <#T##userdata: UnsafeMutableRawPointer!##UnsafeMutableRawPointer?#>)
    print("Freeing mobile_image_mounter client...")
    mobile_image_mounter_free(mimclient)
}


struct iDevice: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var uuid: String
}
