//
//  TodoModel.swift
//  TodoList_RoR
//
//  Created by Farzaad Goiporia on 2024-08-22.
//

import Foundation

struct TodoModel: Codable, Identifiable {
    let id: Int?
    let title: String
    let body: String?
}
