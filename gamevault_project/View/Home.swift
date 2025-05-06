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
            
            GameCollection()
                .tabItem {
                Label("Collection", systemImage: "list.bullet")
            }
            
            AddGame()
                .tabItem {
                Label("Add Game", systemImage: "plus")
            }
            
            HomePage()
                .tabItem {
                Label("Home Page", systemImage: "house")
            }
                
        }.accentColor(.black)
        
    }
}

#Preview {
    Home()
}
