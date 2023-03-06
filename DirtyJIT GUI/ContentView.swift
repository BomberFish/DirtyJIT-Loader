//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct ContentView: View {
    @State var showError = false
    @discardableResult // Add to suppress warnings when you don't want/need a result
    func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/bash") //<--updated
        task.standardInput = nil

        try task.run() //<--updated
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    var body: some View {
        VStack {
            Text("Download from https://github.com/verygenericname/WDBDDISSH/actions")
            Text("Unzip into ~/Downloads/JIT")
            Text("Rename files to JIT.dmg and JIT.dmg.signature")
            Button(action: {
                    do {
                        print(try safeShell("ideviceimagemounter ~/Downloads/JIT/JIT.dmg ~/Downloads/JIT/JIT.dmg.signature"))
                    }
                    catch {
                        showError = true
                        print("\(error)") //handle or silence the error here
                    }

                  }) {
                    Text("Load it!").font(.body)
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
