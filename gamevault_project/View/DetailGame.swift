//
//  DetailGame.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-02.
//

import SwiftUI

let detail = Game(
    id: 1,
    name: "The Elder Scrolls IV: Oblivion",
    deck: "An open-world RPG set in the world of Tamriel.",
    genres: "RPG Action",
    image: "https://www.giantbomb.com/a/uploads/square_avatar/20/201266/3572185-6382658478-co1ou.png",
    publishers: "Bethesda"
)

struct DetailGame: View {
    @State var obj: Game
    @State private var nav = false
    @State private var nav2 = false
    @State private var toastMessage: String? = nil
    private let firebase = FirebaseServices()
    
    @AppStorage("currentUsername") var currentUsername: String = ""
    @State var addtoFav: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                Spacer()
                Button(action: {
                    addtoFav.toggle()
                    Task {
                        if addtoFav {
                            await firebase.addFav(currentUsername, obj)
                            toastMessage = "Added to Favorites"
                            
                        } else {
                            await firebase.removeFav(currentUsername, obj)
                            toastMessage = "Removed to Favorites"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    toastMessage = nil
                        }
                    }
                }) {
                    Image(systemName: addtoFav ? "heart.fill" : "heart")
                        .foregroundColor(addtoFav ? .gold : .gray)
                        .font(.title)
                }.onAppear {
                    Task {
                        let isFavorited = await firebase.isFav(currentUsername, obj)
                        addtoFav = isFavorited
                    }
                }

            }.padding()
            HStack{
                Spacer()
                
                if let url = URL(string: obj.image),
                   let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.trailing)
                    
                } else {
                    Text("Image failed to load")
                }
                Spacer()
            }
           
            VStack(alignment: .leading, spacing: 30) {
                
                HStack{
                    Spacer()
                    Text(obj.name)
                        .font(.largeTitle)
                        .bold()
                        .fontDesign(.monospaced)
                        .foregroundColor(.gold)
                    Spacer()
                }
                
                ScrollView(.vertical){
                    HStack {
                        Text(obj.deck)
                            .fontDesign(.monospaced)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                }
                .frame(height: 150)

                Text("Genre: \(obj.genres)")
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                   
                Text("Publisher: \(obj.publishers)")
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Button (action: {
                    Task {
                        await firebase.removeGame(currentUsername, obj)
                        toastMessage = "Game removed from Collection!"
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            toastMessage = nil
                            nav2 = true
                        }
                    }
                }){
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.black)
                        .frame(width: 350, height: 45)
                        .padding()
                        .overlay {
                            VStack {
                                HStack (alignment: .center){
                                    Text("Delete")
                                        .foregroundStyle(.white)
                                        .font(.title2)
                                        .fontDesign(.monospaced)
                                }
                            }
                        }
                }.fullScreenCover(isPresented: $nav2) {
                    Home()
                }
            
            }.padding()
            Spacer()
            
        }.background(LinearGradient(gradient: Gradient(colors: [ Color.black.opacity(0.9), Color.yellow.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
            .toast($toastMessage)
    }
}
#Preview {
    DetailGame(obj: detail)
}
