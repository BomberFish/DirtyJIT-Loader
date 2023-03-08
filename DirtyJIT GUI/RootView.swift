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
                        if showActionView {
                            VStack {
                                ActionView(device: selectedDevice)
                                VStack {
                                    Label("Back", systemImage: "chevron.left")
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .buttonStyle(PlainButtonStyle())
                                }
                                .onTapGesture {
                                    dismissActionView()
                                }
                            }
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
                                    .onAppear {
                                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                            allDevices = getDevices()
                                            if !(allDevices.isEmpty) {
                                                timer.invalidate()
                                            }
                                        }
                                    }
                                } else {
                                    VStack {
                                        if allDevices.count == 1 {
                                            Text("1 device found")
                                                .font(.system(.largeTitle))
                                        } else {
                                            Text(String(allDevices.count))
                                                .font(.system(.largeTitle))
                                        }
                                            
                                        ForEach(allDevices) { device in
                                            HStack {
                                                Image("iPhone-Notch")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                VStack {
                                                    Text(device.name)
                                                        .font(.system(.title2))
                                                    if redactUUID {
                                                        Text("0000XXXX-XXXXXXXXXXXXXXXX")
                                                    } else {
                                                        Text(device.uuid)
                                                    }
                                                }
                                            }
                                                
                                            .padding()
                                            .frame(maxWidth: 450, maxHeight: 200)
                                            .background(.regularMaterial)
                                            .cornerRadius(10)
                                                
                                            .onTapGesture {
                                                print("Selected \(device.name)")
                                                presentActionView(device: device)
                                                if getDevices().isEmpty {
                                                    allDevices = []
                                                    dismissActionView()
                                                }
                                            }
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

    func presentActionView(device: iDevice) {
        selectedDevice = device
        showActionView = true
    }

    public func dismissActionView() {
        showActionView = false
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
