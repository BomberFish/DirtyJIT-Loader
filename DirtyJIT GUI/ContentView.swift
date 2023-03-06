//
//  ContentView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct ContentView: View {
    @State var showError = false
    @State var gradientReversed = false
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .teal],
                startPoint: gradientReversed ? .topLeading : .bottomLeading,
                endPoint: gradientReversed ? .bottomTrailing : .topTrailing
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 10.0).repeatForever(autoreverses: true)) {
                    gradientReversed.toggle()
                }
            }
            // FIXME: this could be done better :trolley:
            VStack {
                HStack {
                    Button(action: {}, label: {Label("Open DMG", systemImage: "doc")})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .buttonStyle(PlainButtonStyle())
                    Button(action: {}, label: {Label("Open signature", systemImage: "doc")})
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                        .buttonStyle(PlainButtonStyle())
                }
                VStack {
                    Link(destination: URL(string: "https://nightly.link/verygenericname/WDBDDISSH/workflows/main/main")!, label: {
                        Label("Download support DMGs", systemImage: "arrow.down.circle")
                    })
                    .padding()
                    .foregroundColor(.white)
                }
                .background(.blue)
                .cornerRadius(10)
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
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
