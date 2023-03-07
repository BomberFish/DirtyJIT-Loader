//
//  SettingsView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct SettingsView: View {
    @State var redactUUID = UserDefaults.standard.bool(forKey: "redactUUID")
    var body: some View {
        VStack {
            Toggle(isOn: $redactUUID, label:{Text("Redact UUIDs")})
                .toggleStyle(.switch)
                .tint(.accentColor)
                .onChange(of: redactUUID) { new in
                    // set the user defaults
                    UserDefaults.standard.set(new, forKey: "redactUUID")
                }
            Text("Restart app to apply.")
        }
        
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
