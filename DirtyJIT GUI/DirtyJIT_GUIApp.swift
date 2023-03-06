//
//  DirtyJIT_GUIApp.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

@main
struct DirtyJIT_GUIApp: App {
    var body: some Scene {
        WindowGroup("") {
            ContentView()
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
