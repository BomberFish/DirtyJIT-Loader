//
//  TypeUtils.swift
//  DirtyJIT Loader
//
//  Created by Hariz Shirazi on 2023-03-08.
//

import Foundation

func stringToUnsafeUint8(string: String) -> UnsafeMutablePointer<Int8> {
    let cs = (string as NSString).utf8String
    let buffer = UnsafeMutablePointer<Int8>(mutating: cs)
    return buffer!
}

func getFileSizeAsInt(path: String) -> Int {
    do {
        //return [FileAttributeKey : Any]
        let attr = try FileManager.default.attributesOfItem(atPath: path)
        return attr[FileAttributeKey.size] as! Int
        //if you convert to NSDictionary, you can get file size old way as well.
        //let dict = attr as NSDictionary
        //return Int(dict.fileSize())
    } catch {
        print("Error getting size!")
        print("Error: \(error)")
        return -1
    }
}

func getFileSizeAsUInt16(path: String) -> UInt16 {
    do {
        //return [FileAttributeKey : Any]
        let attr = try FileManager.default.attributesOfItem(atPath: path)
        return attr[FileAttributeKey.size] as! UInt16
        //if you convert to NSDictionary, you can get file size old way as well.
        //let dict = attr as NSDictionary
        //return Int(dict.fileSize())
    } catch {
        print("Error getting size!")
        print("Error: \(error)")
        return 0
    }
}

func stringToUnsafeChar(string: String) -> UnsafePointer<CChar> {
    return string.withCString { $0 }
}

// Thanks, ChatGPT!
func fileToUnsafeCchar(path: String) -> UnsafePointer<CChar> {
    do {
        let data = try Data(contentsOf: URL.init(string: path)!)
        let unsafePointer = data.withUnsafeBytes { $0.bindMemory(to: CChar.self).baseAddress }
        return unsafePointer!
    }
    catch {
        print("penis")
    }
    return stringToUnsafeChar(string: "")
}
