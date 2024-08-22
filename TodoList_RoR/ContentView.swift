//
//  ContentView.swift
//  TodoList_RoR
//
//  Created by Farzaad Goiporia on 2024-08-22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showAddTodoView = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                List {
                    ForEach(viewModel.todos) { todo in
                        HStack{
                            Text(todo.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                // Action to delete the item
                                viewModel.deleteTodo(id: todo.id!)
                                if let index = viewModel.todos.firstIndex(where: { $0.id == todo.id }) {
                                    viewModel.todos.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions {
                            Button() {
                                // Action to delete the item
                                
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchTodos()
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            // Action for the button
                            showAddTodoView = true
                            print("FAB tapped")
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding()
                    }
                }
                .navigationDestination(isPresented: $showAddTodoView) {
                    AddTodoView()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
