//
//  User.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var username: String
    var email: String
}
