//
//  Game.swift
//  gamevault_project
//
//  Created by Tran Ba Minh Huy on 2025-03-07.
//

import Foundation

struct Game: Codable, Identifiable {
    var id: String
    var title: String
    var genre: String
    var desc: String
    var platform: String
    var gameForm: String
    var price: String
    var isNew: Bool
    var isUnfinished: Bool;
}

