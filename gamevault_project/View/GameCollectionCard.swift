//
//  GameCollectionCard.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-04-01.
//

import SwiftUI

let model = Game(
    id: 1,
    name: "The Elder Scrolls IV: Oblivion",
    deck: "An open-world RPG set in the world of Tamriel.",
    genres: "RPG Action",
    image: "https://www.giantbomb.com/a/uploads/square_avatar/20/201266/3572185-6382658478-co1ou.png",
    publishers: "Bethesda"
)


struct GameCollectionCard: View {
    var obj: Game
    private let firebase = FirebaseServices()
    @State private var addtoFav = false
    
    @AppStorage("currentUsername") var currentUsername: String = ""
    var body: some View {
        VStack {
            HStack {
                if let url = URL(string: obj.image),
                   let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .padding(.trailing)
                } else {
                    Text("Image failed to load")
                }
                
                
                VStack (alignment: .leading){
                    Text(obj.name)
                        .font(.headline)
                        .fontDesign(.monospaced)
                    Text(obj.genres)
                        .font(.subheadline)
                        .fontDesign(.monospaced)
                }
                
                Spacer()
            
                    Toggle("",isOn: $addtoFav)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .gold))
                        .onChange(of: addtoFav) { newValue in
                            Task {
                                if newValue == true{
                                    await firebase.addFav(currentUsername, obj)
                                }
                                else {
                                    newValue == false
                                    await firebase.removeFav(currentUsername, obj)
                                }
                            }
                        }
            }
        }.padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    GameCollectionCard(obj: model)
}
