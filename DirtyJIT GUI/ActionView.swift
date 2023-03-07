//
//  ActionView.swift
//  DirtyJIT Loader
//
//  Created by Hariz Shirazi on 2023-03-07.
//

import SwiftUI

struct ActionView: View {
    @State public var device: iDevice
    @State var dmgPath = ""
    @State var sigPath = ""
    var body: some View {
        VStack {
            Text(device.name)
                .font(.system(.largeTitle))
            HStack {
                VStack {
                    Text(dmgPath)
                    VStack {
                        Label("Choose DMG", systemImage: "doc")
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        print("would open dmg")
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = false
                        // This is deprecated but I couldn't give a single flying fuck,
                        panel.allowedFileTypes = ["dmg"]
                        if panel.runModal() == .OK {
                            self.dmgPath = panel.url?.lastPathComponent ?? "<none>"
                        }
                    }
                }
                VStack {
                    Text(sigPath)
                    VStack {
                        Label("Choose DMG Signature", systemImage: "doc")
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        print("would open dmg sig")
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = false
                        // This is deprecated but I couldn't give a single flying fuck,
                        panel.allowedFileTypes = ["signature"]
                        if panel.runModal() == .OK {
                            self.sigPath = panel.url?.lastPathComponent ?? "<none>"
                        }
                    }
                }
            }
            Text("")
            VStack {
                Label("Download Link", systemImage: "arrow.down.circle")
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.white)
            }
            .onTapGesture {
                NSWorkspace.shared.open(NSURL(string: "https://nightly.link/verygenericname/WDBDDISSH/workflows/main/main")! as URL)
            }
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(device: iDevice(name: "Example iPhone", uuid: "0000XXXX-XXXXXXXXXXXXXXXX"))
    }
}
