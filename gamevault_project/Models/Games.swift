//
//  Game.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//
import Foundation

struct ReturnGames: Codable {
    let results: [Games]
}

struct Games: Codable, Identifiable {
    var id: Int
    var guid: String
}

extension Games {
    static func fetchGame(withName title: String) async -> [Games] {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
        let baseURL = "https://www.giantbomb.com/api/games/"
        let urlTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
        
        let urlString = "\(baseURL)?api_key=\(apiKey)&format=json&filter=name:\(urlTitle)&limit=5"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return []
        }
        
        do {

            let (data, _) = try await URLSession.shared.data(from: url)
            
            let fetched = try JSONDecoder().decode(ReturnGames.self, from: data)
            let games = fetched.results
            
            if games.isEmpty {
                print("Nothing found for title: \(title)")
            }
            
            return games
        } catch {
            print("Error fetching games: \(error)")
            print("URL: \(urlString)")
            return []
        }
    }
}
