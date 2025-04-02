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
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
                
                
                Text(obj.name)
                    .fontDesign(.monospaced)
                    .bold(true)
                    .font(.title2)
            }
            
            Text("Genre: \(obj.genres)")
                .fontDesign(.monospaced)
            
            Text("Published by \(obj.publishers)")
                .fontDesign(.monospaced)
            
            Text("Decription: \(obj.deck)")
                .fontDesign(.monospaced)
        }
    }
}

#Preview {
    DetailGame(obj: detail)
}
