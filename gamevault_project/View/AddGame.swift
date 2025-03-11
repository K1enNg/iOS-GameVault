//
//  AddGame.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-09.
//

import SwiftUI

struct AddGame: View {
    @State private var title: String = ""
    @State private var genre: String = ""
    @State private var desc: String = ""
    @State private var gameForm: String = ""
    @State private var platform: String = ""
    @State private var price: String = "";
    @AppStorage("currentUsername") var currentUsername: String = ""
    
    let forms : [String] = ["Digital", "Physical"]
    
    private let firestoreService = FirebaseServices()

    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 20) {
                Text("Add Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.monospaced)
                    .padding(.bottom )
                
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Genre", text: $genre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("Select the Game's Form", selection: $gameForm) {
                    ForEach(forms, id: \.self) { form in
                        Text(form)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Platform", text: $platform)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Price", text: $price)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Description", text: $desc)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 20)
            }
            
            Button (action : {
                Task {
                    let id = UUID().uuidString
                    let game = Game(id: id, title: title, genre: genre, desc: desc, platform: platform, gameForm: gameForm, price: price, isNew: false, isUnfinished: false)
                    await firestoreService.addGame(currentUsername, game)
                    
                }
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .frame(width: 350, height: 45)
                    .overlay {
                        Text("Add Game")
                            .font(.title3)
                            .fontDesign(.monospaced)
                            .foregroundColor(.white)
                            .bold()
                    }
            }
            
            
        }.padding()
    }
}

#Preview {
    AddGame()
}
