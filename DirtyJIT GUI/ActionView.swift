//
//  ActionView.swift
//  DirtyJIT Loader
//
//  Created by Hariz Shirazi on 2023-03-07.
//

import SwiftUI

struct ActionView: View {
    @State public var device: iDevice
    var body: some View {
        VStack {
            Text("Action View ")
            Text(device.name)
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(device: iDevice(name: "Example iPhone", uuid: "00008020-XXXXXXXXXXXXXXXX"))
    }
}
