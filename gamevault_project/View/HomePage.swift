//
//  HomePage.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-01.
//

import SwiftUI


struct HomePage: View {
    let platforms = ["play", "xboxx", "epic", "battlenet", "ubis", "nintendo", "steam", "rockstar"]
    @State private var currentIndex = 0
    @State private var toastMessage: String? = nil
    @State private var nav = false
    @State private var nav2 = false
    @State private var nav3 = false
    private let firestoreService = FirebaseServices()
    @State private var games: [Game] = []
    @AppStorage("currentUsername") var currentUsername: String = ""
    
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
                .foregroundColor(.gold)
            
            Divider()
            
            HStack{
                Image(systemName: "plus.app")
                    .scaledToFit()
                    .padding(.trailing, 7)
                    .foregroundColor(.gold)
                Text("Add your favorite games")
                    .font(.body)
                    .fontDesign(.monospaced)
                    .foregroundColor(.gold)
            }
            
            Divider()
            
            HStack{
                Image(systemName: "gamecontroller")
                    .foregroundColor(.gold)
                    .scaledToFit()
                Text("View your entire game collection")
                    .font(.body)
                    .foregroundColor(.gold)
                    .fontDesign(.monospaced)
            }
            
            Divider()
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(Array(platforms.enumerated()), id: \.element) { index, platform in
                            Image(platform)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                                .shadow(radius: 5)
                                .cornerRadius(12)
                                .id(index)
                        }
                    }
                    .padding(.vertical)
                }
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo(currentIndex, anchor: .center)
                        }
                        currentIndex = (currentIndex + 1) % platforms.count
                    }
                }
            }
            
            Divider()
            
            VStack{
                Text("Collection Summary")
                    .fontWeight(.bold)
                    .fontDesign(.monospaced)
                
                HStack{
                    Text("Total Games: \(games.capacity)")
                        .fontDesign(.monospaced)
                    Image(systemName: "books.vertical")
                }
                
                Button (action: {
                    Task {
                        await firestoreService.logOut()
                        currentUsername = ""
                        toastMessage = "Logged out successfully!"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            toastMessage = nil
                            nav3 = true
                        }
    
                    }
                }){
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.black)
                        .frame(width: 350, height: 45)
                        .padding()
                        .overlay {
                            HStack (alignment: .center){
                                Text("Log Out")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .fontDesign(.monospaced)
                            }
                        }
                }
                .fullScreenCover(isPresented: $nav3) {
                    LogInView()
                }
            }
            Spacer()
                .task {
                    await getAllGames()
                }
        }.padding()
            .background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            .toast($toastMessage)
    }
    
    private func getAllGames() async {
        let getGames = await firestoreService.displayGames(currentUsername, "All")
        var genresGames = await firestoreService.displayGenres(currentUsername)
           DispatchQueue.main.async {
               self.games = getGames
           }
    }
}

#Preview {
    HomePage()
}
