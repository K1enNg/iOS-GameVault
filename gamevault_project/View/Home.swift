//
//  Home.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-02.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            
            HomePage().tabItem {
                Label("Home Page", systemImage: "house")
            }
            
            AddGame()
                .tabItem {
                    Label("Add Game", systemImage: "plus")
                }
            
            GameCollection()
                .tabItem {
                    Label("Collection", systemImage: "list.bullet")
                }
            
                
        }.background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    Home()
}
