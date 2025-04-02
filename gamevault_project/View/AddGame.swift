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
            VStack (alignment: .leading, spacing: 20) {
                Text("Add Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.monospaced)
                
                HStack {
                    TextField("Search Game", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button (action : {
                        Task {
                            await fetchGames()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black)
                            .frame(width: 45, height: 45)
                            .overlay {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 20))
                                    .bold(true)
                                    .foregroundStyle(.white)
                            }
                    }
                }
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
            }
           
            Spacer()
        }.padding()
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
