//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import FluidGradient
import SwiftUI

struct RootView: View {
    @State var showError = false
    @State var gradientReversed = false
    @State var redactUUID = UserDefaults.standard.bool(forKey: "redactUUID")
    @State var allDevices = getDevices()
    @State var showActionView = false
    @State var selectedDevice = iDevice(name: "", uuid: "")
    // Fun fact: I made demo mode because I forgot to bring my Lightning cable to school
    @State var demoMode = UserDefaults.standard.bool(forKey: "demoMode")
    
    var body: some View {
        ZStack {
            FluidGradient(blobs: [.accentColor, Color(NSColor.darkGray), .blue],
                          highlights: [.teal, .blue, Color(NSColor.systemBlue)],
                          speed: 0.15,
                          blur: 0.5)
                .ignoresSafeArea()
            VStack {
                VStack {
                    VStack {
                        if showActionView && !(allDevices.isEmpty){
                            VStack {
                                ActionView(device: selectedDevice)
                                VStack {
                                    Button(action:{
                                        NSWorkspace.shared.open(NSURL(string: "https://nightly.link/verygenericname/WDBDDISSH/workflows/main/main")! as URL)
                                    }, label:{
                                        Label("Download Link", systemImage: "arrow.down.circle")
                                            .padding()
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    //.background(.thinMaterial)
                                }
                                //.clipShape(RoundedRectangle(cornerRadius: 10))
                                // handle clicks on the bg
                                .onTapGesture {
                                    NSWorkspace.shared.open(NSURL(string: "https://nightly.link/verygenericname/WDBDDISSH/workflows/main/main")! as URL)
                                }
                                    VStack {
                                    Label("Back", systemImage: "chevron.left")
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .buttonStyle(PlainButtonStyle())
                                        .padding()
                                }
                                .onTapGesture {
                                    showActionView = false
                                }
                            }
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(10)
                        } else {
                            VStack {
                                if allDevices.isEmpty {
                                    VStack {
                                        VStack {
                                            Image(systemName: "iphone.slash")
                                                .font(.system(size: 50))
                                            Text("No devices connected")
                                                .font(.system(.largeTitle))
                                                .fontWeight(.bold)
                                            Text("Connect an iPhone, iPad, or iPod touch to continue.")
                                                .font(.system(.headline))
                                                .fontWeight(.regular)
                                            Text("")
                                            ProgressView()
                                                .scaleEffect(0.85)
                                        }
                                        .padding()
                                    }
                                    
                                } else {
                                    VStack {
                                        if allDevices.count == 1 {
                                            Text("1 device found")
                                                .font(.system(.largeTitle))
                                                .fontWeight(.bold)
                                        } else {
                                            Text("\(String(allDevices.count)) devices found")
                                                .font(.system(.largeTitle))
                                                .fontWeight(.bold)
                                        }
                                            
                                        ForEach(allDevices) { device in
                                            HStack {
                                                Image("iPhone-Notch")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                VStack {
                                                    Text(device.name)
                                                        .font(.system(.title2))
                                                    if redactUUID && !demoMode {
                                                        Text("0000XXXX-XXXXXXXXXXXXXXXX")
                                                    } else {
                                                        Text(device.uuid)
                                                    }
                                                    VStack {
                                                        Button(action:{
                                                            print("Selected \(device.name)")
                                                            selectedDevice = device
                                                            showActionView = true
                                                        }, label:{
                                                            Label("Choose this device", systemImage: "checkmark.circle")
                                                                .padding()
                                                        })
                                                        .buttonStyle(PlainButtonStyle())
                                                        .background(.thinMaterial)
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    // handle clicks on the bg
                                                    .onTapGesture {
                                                        print("Selected \(device.name)")
                                                        selectedDevice = device
                                                        showActionView = true
                                                    }
                                                }
                                            }
                                                
                                            .padding()
                                            .frame(maxWidth: 450, maxHeight: 200)
                                            .background(.regularMaterial)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    Text("DirtyJIT Loader \(appVersion)\nBy BomberFish")
                        .font(.system(.footnote))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(NSColor.secondaryLabelColor))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .onAppear {
                if demoMode {
                    allDevices = []
                    print("DEMO MODE")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        print("Displaying demo devices...")
                        allDevices = [iDevice(name: "Example iPhone XR", uuid: "00008020-XXXXXXXXXXXXXXXX"), iDevice(name: "Example iPhone 11", uuid: "00008030-XXXXXXXXXXXXXXXX")]
                    }
                } else {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        allDevices = getDevices()
                        //                    if !(allDevices.isEmpty) {
                        //                        timer.invalidate()
                        //                    }
                    }
                }
            }
                
            .alert("Error!", isPresented: $showError) {
                Button("OK", role: .cancel) {}
            }
            .toolbar {
                Spacer()
                HStack {
                    Image("DirtyJIT-Symbolic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("DirtyJIT")
                        .fontWeight(.bold)
                        .font(.system(.title2))
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
