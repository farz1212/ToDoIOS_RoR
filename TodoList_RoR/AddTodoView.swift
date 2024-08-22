//
//  AddTodoView.swift
//  TodoList_RoR
//
//  Created by Farzaad Goiporia on 2024-08-22.
//

import SwiftUI

struct AddTodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    @State private var newTitle: String = ""
    @State private var newBody: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            
            // Title TextField
            TextField("Enter title", text: $newTitle)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
            // Body TextField
            TextField("Enter body", text: $newBody, axis: .vertical)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .lineLimit(5)
                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
            
            Spacer()
            
            HStack {
                // Clear Button
                Button(action: {
                    // Clear the text fields
                    newTitle = ""
                    newBody = ""
                }) {
                    Text("Clear")
                        .foregroundColor(.white)
                        .frame(width: 120)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .padding(.trailing, 10)
                
                // Create Button
                Button(action: {
                    
                    // Placeholder for action
                    viewModel.createTodo(title: newTitle, body: newBody)
                }) {
                    Text("Create Todo")
                        .foregroundColor(.white)
                        .frame(width: 120)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
