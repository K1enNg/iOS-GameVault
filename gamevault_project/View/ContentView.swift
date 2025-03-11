//
//  ContentView.swift
//  gamevault_project
//
//  Created by Macbook de Kien on 2025-02-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                AddGame()
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Add Game")
                    }
                
                Text("Profile")
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
                
                Text("Collection")
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Collection")
                    }
                
                Text("Noftifications")
                    .tabItem {
                        Image(systemName: "bell.badge.fill")
                        Text("Noftifications")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
