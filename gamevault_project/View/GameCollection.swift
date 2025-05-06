//
//  GameCollection.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-01.
//

import SwiftUI

struct GameCollection: View {
    @AppStorage("currentUsername") var currentUsername: String = ""
    private let firestoreService = FirebaseServices()
    @State private var games: [Game] = []
    @State private var genres: [String] = []
    @State private var selectedGenre: String = "All"
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack(alignment: .center){
                    Text("GameVault")
                        .font(.title)
                        .bold(true)
                        .foregroundColor(.gold)
                        .fontDesign(.monospaced)
                    
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .frame(width: 40, height: 30)
                        .foregroundColor(.gold)
                }
                
                HStack (){
                    Text("Game Collection")
                        .fontDesign(.monospaced)
                        .font(.title)
                        .bold(true)
                        .padding(.bottom)
                        .foregroundColor(.gold)
                    
                    Spacer()
                    Picker("Select Genre", selection: $selectedGenre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre).tag(genre)
                        }
                    }
                    .accentColor(.gold)
                    .pickerStyle(MenuPickerStyle()) .onChange(of: selectedGenre) { _ in
                        Task { await getAllGames()}
                    }
                }
            
            if (games.isEmpty) {
                ProgressView("Loading games...")
                    .padding(.trailing)
                    .foregroundColor(.gold)
            } else {
                ScrollView{
                    ForEach(games, id: \.id) { game in
                        NavigationLink(destination:
                            DetailGame(obj: game)) {
                            GameCollectionCard(obj: game)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.black)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .task{
            await getAllGames()
        }
        .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            
    }
}
    
    private func getAllGames() async {
        let getGames = await firestoreService.displayGames(currentUsername, selectedGenre)

        var genresGames = await firestoreService.displayGenres(currentUsername)
        
        genresGames.append("All")
        
           DispatchQueue.main.async {
               self.games = getGames
               self.genres = genresGames
           }
    }
}



#Preview {
    GameCollection()
}
