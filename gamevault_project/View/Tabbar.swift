//
//  Tabbar.swift
//  gamevault_project
//
//  Created by Macbook de Kien on 2025-03-04.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0

    let tabs = [
        (name: "Home", icon: "house.fill"),
        (name: "Collections", icon: "square.grid.2x2.fill"),
        (name: "Notifications", icon: "bell.fill"),
        (name: "Profile", icon: "person.crop.circle")
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Spacer()
                    VStack {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 24))
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                        Text(tabs[index].name)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                    .padding()
                    .onTapGesture {
                        selectedTab = index
                    }
                    Spacer()
                }
            }
            .background(Color.white.shadow(radius: 10))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

