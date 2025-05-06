//
//  AddGame.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-09.
//

import SwiftUI


struct AddGame: View {
    @State private var name: String = ""
    @State private var genre: String = ""
    @State private var desc: String = ""
    @State private var publisher: String = ""
    @State private var releaseDate: String = ""
    @State private var rating: String = "";
    @State private var fetchedGames: [Game] = []
    @AppStorage("currentUsername") var currentUsername: String = ""
    private let firestoreService = FirebaseServices()
    

    var body: some View {
        VStack {
            VStack (spacing: 20) {
                HStack{
                    Text("Add Game")
                        .font(.largeTitle)
                        .bold()
                        .fontDesign(.monospaced)
                        .foregroundColor(.gold)
                }
                
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: 380, height: 30)
                    .overlay(
                HStack {
                    TextField("Search Game", text: $name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .foregroundColor(.gold)
                    
                    Button (action : {
                        Task {
                            await fetchGames()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gold)
                            .frame(width: 35, height: 35)
                            .overlay {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 20))
                                    .bold(true)
                                    .foregroundStyle(.black)
                            }
                    }.padding(.leading)
                })
            }
            
            if (!fetchedGames.isEmpty) {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(fetchedGames, id: \.id) { game in
                            GameCard(obj: game)
                            Divider()
                        }
                    }
                }
                .frame(maxHeight: 900)
            }
            else {
                ProgressView("Loading results...")
                    .foregroundColor(.gold)
            }
           
            Spacer()
        }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
    }
    
   func fetchGames() async {
       let listID = await Games.fetchGame(withName: name)
       let games = await GameAssemble.gameList(listID)
       self.fetchedGames = games
   }
}


#Preview {
    AddGame()
}
