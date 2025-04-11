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
    private let firebase = FirebaseServices()
    
    @AppStorage("currentUsername") var currentUsername: String = ""
    @State var addtoFav: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
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
            HStack {
                if let url = URL(string: obj.image),
                   let data = try? Data(contentsOf: url),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 400)
                                .clipped()
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.6), .clear]), startPoint: .bottom, endPoint: .top)
                                )
                    
                    
                } else {
                    Text("Image failed to load")
                }
                
            }
           
            VStack(alignment: .leading, spacing: 4) {
                Text(obj.name)
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                
                HStack {
                    Text(obj.deck)
                        .fontDesign(.monospaced)
                        .foregroundColor(.black)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .shadow(radius: 2)

                Text("Genre: \(obj.genres)")
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                   
                Text("Publisher: \(obj.publishers)")
                    .fontDesign(.monospaced)
                    .foregroundColor(.black)
                    
            }.padding(.horizontal)
            Spacer()
        }.background(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.3), Color.black.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
        
        
    }
    
   
}

#Preview {
    DetailGame(obj: detail)
}
