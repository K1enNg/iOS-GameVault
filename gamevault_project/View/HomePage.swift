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
            
            
            Button  {
                nav = true
            } label: {
                HStack{
                    Image(systemName: "gamecontroller")
                        .foregroundColor(.black)
                        .scaledToFit()
                    Text("Game Collection")
                        .font(.body)
                        .foregroundColor(.black)
                        .fontDesign(.monospaced)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                    
                }
            }.fullScreenCover(isPresented: $nav) {
                GameCollection()
            }
            
            Divider()
        
            
            Button {
                nav2 = true
            } label: {
                HStack{
                    Image(systemName: "plus.app")
                        .foregroundColor(.black)
                        .scaledToFit()
                        .padding(.trailing, 7)
                    Text("Add game")
                        .font(.body)
                        .fontDesign(.monospaced)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                    
                }
            }.fullScreenCover(isPresented: $nav2) {
                AddGame()
            }
            
            Divider()
            
            Spacer()
            
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
            
        }.padding()
    }
}

#Preview {
    HomePage()
}
