//
//  HomePage.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-01.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        VStack {
            Image("gameVaultLogo")
                .resizable()
                .scaledToFit()
            
            
            Divider()
            
            HStack{
                Image(systemName: "gamecontroller")
                    .foregroundColor(.black)
                    .scaledToFit()
                Text("Game Collection")
                    .font(.body)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                
            }
            
            Divider()
        
            
            HStack{
                Image(systemName: "plus.app")
                    .foregroundColor(.black)
                    .scaledToFit()
                Text("Add game")
                    .font(.body)
                  
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                
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
                HStack{
                    
                    Text("Total Value: ")
                        .fontDesign(.monospaced)
                    Image(systemName: "dollarsign.circle")
                }
            }
            
        }.padding()
    }
}

#Preview {
    HomePage()
}
