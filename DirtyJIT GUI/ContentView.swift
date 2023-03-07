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
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .teal],
                startPoint: gradientReversed ? .topLeading : .bottomLeading,
                endPoint: gradientReversed ? .bottomTrailing : .topTrailing
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeInOut(duration: 6.0).repeatForever(autoreverses: true)) {
                    gradientReversed.toggle()
                }
            }
            // FIXME: this could be done better :trolley:
            VStack {
                HomeView()
                Text("DirtyJIT GUI \(appVersion)\nBy BomberFish")
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
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
