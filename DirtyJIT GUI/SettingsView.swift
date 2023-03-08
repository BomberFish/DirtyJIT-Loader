//
//  SettingsView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct SettingsView: View {
    @State var redactUUID = UserDefaults.standard.bool(forKey: "redactUUID")
    @State var demoMode = UserDefaults.standard.bool(forKey: "demoMode")
    var body: some View {
        List {
            // stolen from whitelist and cowabunga :s
            Toggle(isOn: $redactUUID, label:{Text("Redact UUIDs")})
                .toggleStyle(.switch)
                .tint(.accentColor)
                .onChange(of: redactUUID) { new in
                    // set the user defaults
                    UserDefaults.standard.set(new, forKey: "redactUUID")
                }
            Toggle(isOn: $demoMode, label:{Text("Demo Mode")})
                .toggleStyle(.switch)
                .tint(.accentColor)
                .onChange(of: demoMode) { new in
                    // set the user defaults
                    UserDefaults.standard.set(new, forKey: "demoMode")
                }
            Text("Restart app to apply.")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
