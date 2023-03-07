//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct RootView: View {
    @State var showError = false
    @State var gradientReversed = false
    @State var redactUUID = UserDefaults.standard.bool(forKey: "redactUUID")
    @State var allDevices = getDevices()
    
    var body: some View {
        //NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.blue, .teal],
                    startPoint: gradientReversed ? .topLeading : .bottomLeading,
                    endPoint: gradientReversed ? .bottomTrailing : .topTrailing
                )
                .ignoresSafeArea()
//                .onAppear {
//                    withAnimation(.easeInOut(duration: 6.0).repeatForever(autoreverses: true)) {
//                        gradientReversed.toggle()
//                    }
//                }
                // FIXME: this could be done better :trolley:
                VStack {
                    // FIXME: this could be done better :trolley:
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
                                }
                                .padding()
                                
                                VStack {
                                    Label("Rescan", systemImage: "arrow.triangle.2.circlepath")
                                        .padding()
                                        .background(.blue)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .buttonStyle(PlainButtonStyle())
                                }
                                .onTapGesture {
                                    allDevices = getDevices()
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
                                
                                ForEach(allDevices) {device in
                                    HStack {
                                        Image("iPhone-Notch")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        VStack {
                                            Text(device.name)
                                                .font(.system(.title2))
                                            if redactUUID {
                                                Text("0000****-************")
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
                                        if getDevices().isEmpty {
                                            allDevices = []
                                        } else {
                                            print("Selected \(device.name)")
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                
                .alert("Error!", isPresented: $showError) {
                    Button("OK", role: .cancel) { }
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
        //}
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
