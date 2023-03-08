//
//  ActionView.swift
//  DirtyJIT Loader
//
//  Created by Hariz Shirazi on 2023-03-07.
//

import SwiftUI

struct ActionView: View {
    @State public var device: iDevice
    @State var dmgName = "Choose DMG"
    @State var sigName = "Choose Signature"
    @State var dmgPath = ""
    @State var sigPath = ""
    @State var dmgChosen = false
    @State var sigChosen = false
    var body: some View {
        VStack {
            VStack {
                Text(device.name)
                    .font(.system(.largeTitle))
                    .fontWeight(.bold)
                HStack {
                    VStack {
                        VStack {
                            Button(action:{
                                print("would open dmg")
                                let panel = NSOpenPanel()
                                panel.allowsMultipleSelection = false
                                panel.canChooseDirectories = false
                                // This is deprecated but I couldn't give a single flying fuck,
                                panel.allowedFileTypes = ["dmg"]
                                if panel.runModal() == .OK {
                                    self.dmgName = panel.url?.lastPathComponent ?? "<none>"
                                    self.dmgPath = panel.url!.absoluteString
                                    dmgChosen = true
                                }
                            }, label:{
                                Label(dmgName, systemImage: dmgChosen ? "checkmark.circle" : "doc")
                                    .padding()
                            })
                            .buttonStyle(PlainButtonStyle())
                            .background(.thinMaterial)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        // handle clicks on the bg
                        .onTapGesture {
                            print("would open dmg")
                            let panel = NSOpenPanel()
                            panel.allowsMultipleSelection = false
                            panel.canChooseDirectories = false
                            // This is deprecated but I couldn't give a single flying fuck,
                            panel.allowedFileTypes = ["dmg"]
                            if panel.runModal() == .OK {
                                self.dmgName = panel.url?.lastPathComponent ?? "<none>"
                                self.dmgPath = panel.url!.absoluteString
                                dmgChosen = true
                            }
                        }
                    }
                    VStack {
                        VStack {
                            Button(action:{
                                print("would open dmg sig")
                                let panel = NSOpenPanel()
                                panel.allowsMultipleSelection = false
                                panel.canChooseDirectories = false
                                // This is deprecated but I couldn't give a single flying fuck,
                                panel.allowedFileTypes = ["signature"]
                                if panel.runModal() == .OK {
                                    self.sigName = panel.url?.lastPathComponent ?? "<none>"
                                    self.sigPath = panel.url!.absoluteString
                                    sigChosen = true
                                }
                            }, label:{
                                Label(sigName, systemImage: sigChosen ? "checkmark.circle" : "doc")
                                    .padding()
                            })
                            .buttonStyle(PlainButtonStyle())
                            .background(.thinMaterial)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        // handle clicks on the bg
                        .onTapGesture {
                            print("would open dmg sig")
                            let panel = NSOpenPanel()
                            panel.allowsMultipleSelection = false
                            panel.canChooseDirectories = false
                            // This is deprecated but I couldn't give a single flying fuck,
                            panel.allowedFileTypes = ["signature"]
                            if panel.runModal() == .OK {
                                self.sigName = panel.url?.lastPathComponent ?? "<none>"
                                self.sigPath = panel.url!.absoluteString
                                sigChosen = true
                            }
                        }
                    }
                }
                Text("")
                VStack {
                    VStack {
                        Button(action:{
                            print("would mount image")
                        }, label:{
                            Label("Apply", systemImage: "checkmark.seal")
                                .padding()
                        })
                        .buttonStyle(PlainButtonStyle())
                        .background(.thinMaterial)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    // handle clicks on the bg
                    .onTapGesture {
                        print("would mount image")
                    }
                }
                Text("")
                
            }
        }
        .padding()
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(device: iDevice(name: "Example iPhone", uuid: "0000XXXX-XXXXXXXXXXXXXXXX"))
    }
}
