//
//  FirebaseServices.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseServices {
    private let db = Firestore.firestore()

    func addUser(_ id: String,_ username: String, _ email: String){
        let newUser = User(id: id, username: username, email: email)
        do {
            try db.collection("Users").document(newUser.id).setData(from: newUser)
            print("User Successfully Added!")
        }
        catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
    
    func getUserByUsername(_ username: String) async -> User? {
        do {
            let querySnapshot = try await db.collection("Users")
                                            .whereField("username", isEqualTo: username)
                                            .getDocuments()

            if (querySnapshot.documents.isEmpty) {
                print("No user found with username: \(username)")
                return nil
            }

            let userDocument = querySnapshot.documents.first!
            let user = try userDocument.data(as: User.self)
            return user
            
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func addGame(_ username: String, _ game: Game) async {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return
            }
    
            let ref =  db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document("\(game.genres)")
            
            try await ref.setData(["genreName": game.genres], merge: true)

            try ref.collection("\(game.genres)")
                   .document(game.name)
                   .setData(from: game)
                
        } catch {
            print("Error adding game: \(error.localizedDescription)")
        }
    }
    
    func displayGenres(_ username: String) async -> [String] {
        do {
            
            guard let user = await getUserByUsername(username) else {
                print("User not found")
                return []
            }
            var genres: [String] = []
            
            let genresSnapshot = try await db.collection("Users")
                .document(user.id)
                .collection("Games")
                .getDocuments()
            
            for genre in genresSnapshot.documents {
                genres.append(genre.documentID)
            }
        
            return genres
        }
        catch {
            print("Error displaying game: \(error.localizedDescription)")
            return []
        }
    }
    
    func displayGames(_ username: String, _ sort: String) async -> [Game] {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return []
            }
            
            var allGames: [Game] = []
            
            var genres = await displayGenres(username)
            
            genres = genres.filter { $0 != "Favorite" }
            
            if (sort == "All") {
                for genre in genres{
                    let gameSnaphot = try await
                        db.collection("Users")
                        .document(currentUser.id)
                        .collection("Games")
                        .document("\(genre)")
                        .collection("\(genre)")
                        .getDocuments()
                    
                    let game = gameSnaphot.documents.compactMap { doc in
                        try? doc.data(as: Game.self)
                    }
                   
                    allGames.append(contentsOf: game)
                }
            }
            else {
                let gameSnaphot = try await
                    db.collection("Users")
                    .document(currentUser.id)
                    .collection("Games")
                    .document("\(sort)")
                    .collection("\(sort)")
                    .getDocuments()
                
                let game = gameSnaphot.documents.compactMap { doc in
                    try? doc.data(as: Game.self)
                }
               
                allGames.append(contentsOf: game)
            }
           return allGames
            
        } catch {
            print("Error displaying game: \(error.localizedDescription)")
            return []
        }
    }
    
    func addFav(_ username: String, _ game: Game) async {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return
            }
    
            let ref =  db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document("Favorite")
            
            try await ref.setData(["Favorite": "Favortite"], merge: true)

            try ref.collection("Favorite")
                   .document(game.name)
                   .setData(from: game)
                
        } catch {
            print("Error adding game: \(error.localizedDescription)")
        }
    }
    
    func isFav(_ username: String, _ game: Game) async -> Bool {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return false
            }
    
            let ref =  db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document("Favorite")
                .collection("Favorite")
            
            if (try await ref.document(game.name).getDocument().exists) {
                return true
            }
            else {
                return false
            }
            
                
        } catch {
            print("Error adding game: \(error.localizedDescription)")
        }
        return false
    }
    
    func removeFav(_ username: String, _ game: Game) async {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return
            }
    
            let ref =  db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document("Favorite")
            

            try await ref.collection("Favorite")
                   .document(game.name)
                   .delete()
                
        } catch {
            print("Error removing game from favorite: \(error.localizedDescription)")
        }
    }
    
    func removeGame(_ username: String, _ game: Game) async {
        do {
            guard let currentUser = await getUserByUsername(username) else {
                print("User not found")
                return
            }
            
            await removeFav(username, game)
    
            let ref =  db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document(game.genres)

            try await ref.collection(game.genres)
                   .document(game.name)
                   .delete()
                
        } catch {
            print("Error removing game: \(error.localizedDescription)")
        }
    }
    
    func logOut() async {
        do {
            try Auth.auth().signOut()
           
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
