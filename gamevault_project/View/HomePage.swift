//
//  HomePage.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-01.
//

import SwiftUI

struct HomePage: View {
    @State private var nav = false
    @State private var nav2 = false
    
    var body: some View {
        VStack {
            Image("gameVaultLogo")
                .resizable()
                .scaledToFit()
            
       
            Divider()
            
            
            Text("GameVault is your personal game collection tracker. Add, organize, and view your games. Keep track of your collection and stay on top of your gaming adventures")
                            .font(.body)
                            .fontDesign(.monospaced)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
            
            
            Divider()
            
            HStack{
                Image(systemName: "plus.app")
                    .foregroundColor(.black)
                    .scaledToFit()
                    .padding(.trailing, 7)
                Text("Add your favorite games")
                    .font(.body)
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                
                
            }
            
            Divider()
            
            
            HStack{
                Image(systemName: "gamecontroller")
                    .foregroundColor(.black)
                    .scaledToFit()
                Text("View your entire game collection")
                    .font(.body)
                    .foregroundColor(.black)
                    .fontDesign(.monospaced)
             
                
            }
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(["ps", "xbox", "nin", "steam", "epic",], id: \.self) { platform in
                        Image(platform)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .shadow(radius: 5)
                            .cornerRadius(12)
                    }
                }.padding(.vertical)
            }

            
            
            Divider()
            
            Text("“The video game culture was an important thing to keep alive in the film because we're in a new era right now. The video games are one step before a whole other virtual universe.” – Vin Diesel")
                .font(.footnote)
                .fontDesign(.monospaced)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            
            Divider()
    
            
            VStack{
                Text("Collection Summary")
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                
                HStack{
                    Text("Total Games: ")
                        .fontDesign(.monospaced)
                    Image(systemName: "books.vertical")
                }
            }
            
            Spacer()
            
        }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    HomePage()
}
