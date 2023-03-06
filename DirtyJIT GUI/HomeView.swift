//
//  HomeView.swift
//  DirtyJIT GUI
//
//  Created by Hariz Shirazi on 2023-03-06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
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
            Button(action: {getalldevicenames()}, label: {Label("the funny", systemImage: "ladybug")})
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
