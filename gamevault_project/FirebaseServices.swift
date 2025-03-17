//
//  FirebaseServices.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import Foundation
import FirebaseFirestore

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

            if querySnapshot.documents.isEmpty {
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
    
            try db.collection("Users")
                .document(currentUser.id)
                .collection("Games")
                .document(game.genre)
                .collection("\(game.genre)")
                .document(game.title).setData(from: game)
               
            print("Game added successfully!")
        } catch {
            print("Error updating user: \(error.localizedDescription)")
        }
    }
}
