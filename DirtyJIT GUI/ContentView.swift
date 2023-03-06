//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct ContentView: View {
    @State var showError = false
    var body: some View {
        VStack {
            Text("Download from https://github.com/verygenericname/WDBDDISSH/actions")
            Text("Unzip into ~/Downloads/JIT")
            Text("Rename files to JIT.dmg and JIT.dmg.signature")
            Button(action: {

                  }) {
                    Text("Load it!")
                  }
        }
        .alert("Error!", isPresented: $showError) {
                    Button("OK", role: .cancel) { }
                }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
