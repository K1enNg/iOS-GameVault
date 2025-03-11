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

    func addUser(_ username: String, _ password: String, _ email: String) -> Bool{
        let id = UUID().uuidString
        let newUser = User(id: id, username: username, email: email, password: password)
        do {
            try db.collection("Users").document(newUser.id).setData(from: newUser)
            print("User Successfully Added!")
            return true;
        }
        catch {
            print("Error saving user: \(error.localizedDescription)")
            return false;
        }
    }
    
    func validateUser(_ username: String, _ password: String) async -> Bool {
        let user = await getUserByUsername(username)
        if(user == nil){
            return false;
        }
        else {
            if (user?.password == password) {
                return true;
            }
        }
        return false;
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
