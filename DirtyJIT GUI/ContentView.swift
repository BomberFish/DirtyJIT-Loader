//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct ContentView: View {
    @discardableResult func shell(_ command: String) -> (String?, Int32) {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        task.waitUntilExit()
        return (output, task.terminationStatus)
      }
    var body: some View {
        VStack {
            Text("Download from https://github.com/verygenericname/WDBDDISSH/actions")
            Text("Unzip into ~/Downloads/JIT")
            Button(action: {
                    self.shell("ideviceimagemounter ~/Downloads/JIT/*.dmg ~/Downloads/JIT/*.signature")
                  }) {
                    Text("Load it!").font(.body)
                  }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
