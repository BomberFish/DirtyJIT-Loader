//
//  DirtyJIT_GUIApp.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

let appVersion = ((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown") + " (" + (Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown") + ")")

@main
struct DirtyJIT_GUIApp: App {
    var body: some Scene {
        WindowGroup("") {
            RootView()
                .preferredColorScheme(.dark)
                .onAppear {
                    print("DirtyJIT GUI version \(appVersion)")
                }
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
