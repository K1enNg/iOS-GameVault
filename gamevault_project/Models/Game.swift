//
//  Game.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-28.
//

import Foundation

struct ReturnGame: Codable {
    let results: GameProxy
}

struct GameProxy: Codable, Identifiable {
    var id: Int
    var name: String
    var deck: String
    var genres : [Genre]
    var image : Image
    var publishers: [Publisher]
    
    var genre: String {
        genres.last?.name ?? "Unknown Genre"
    }
    
    var publisher: String {
        publishers.compactMap { $0.name }.joined(separator: ", ") ?? "Unknown Publisher"
    }
    
    var iconURL: String {
        image.icon_url ?? "No Image Available"
    }
    
    struct Publisher: Codable {
        let name: String
    }
    
    struct Image: Codable {
        let icon_url: String
    }
    
    struct Genre: Codable {
        let name: String
    }
}

struct Game: Codable, Identifiable {
    var id: Int
    var name: String
    var deck: String
    var genres : String
    var image : String
    var publishers: String
}


class GameAssemble {
    static func gameList(_ searchId: [Games]) async -> [Game] {
        var gameList: [Game] = []
        
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
        let baseURL = "https://www.giantbomb.com/api/game"
        
        for id in searchId {
            let urlString = "\(baseURL)/\(id.guid)/?api_key=\(apiKey)&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                continue
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let fetched = try JSONDecoder().decode(ReturnGame.self, from: data)
                let games = fetched.results

                let obj = GameProxy(id: games.id, name: games.name, deck: games.deck, genres: games.genres, image: games.image, publishers: games.publishers)
         
                let game = Game(id: obj.id, name: obj.name, deck: obj.deck, genres: obj.genre, image: obj.iconURL, publishers: obj.publisher)
            
                gameList.append(game)
                
            } catch {
                print("Error fetching data for \(id.guid): \(error)")
            }
        }

        return gameList
    }
}
