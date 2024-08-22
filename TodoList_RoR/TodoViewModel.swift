//
//  TodoViewModel.swift
//  TodoList_RoR
//
//  Created by Farzaad Goiporia on 2024-08-22.
//

// TodoViewModel.swift
import Foundation

class TodoViewModel: ObservableObject {
    @Published var todos: [TodoModel] = []
    
    private let url = URL(string: "http://localhost:3000/api/v1/todos/")!
    
    func fetchTodos() {
        
        URLSession.shared.dataTask(with: url) { data, response, _ in
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let todos = try JSONDecoder().decode([TodoModel].self, from: data)
                DispatchQueue.main.async {
                    self.todos = todos
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func createTodo(title: String, body: String) {

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let newTodo = TodoModel(id: nil, title: title, body: body)

            do {
                let jsonData = try JSONEncoder().encode(newTodo)
                request.httpBody = jsonData
            } catch {
                print("Error encoding JSON: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, _ in
                guard let data = data else {
                    print("No data returned")
                    return
                }

                do {
                    let createdTodo = try JSONDecoder().decode(TodoModel.self, from: data)
                    DispatchQueue.main.async {
                        self.todos.append(createdTodo)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    
    // Function to update an existing Todo
    func updateTodo(id: Int, title: String, body: String) {
            guard let url = URL(string: "\(url)/\(id)") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let updatedTodo = TodoModel(id: id, title: title, body: body)

            do {
                let jsonData = try JSONEncoder().encode(updatedTodo)
                request.httpBody = jsonData
            } catch {
                print("Error encoding JSON: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, _ in
                guard let data = data else {
                    print("No data returned")
                    return
                }

                do {
                    let updatedTodo = try JSONDecoder().decode(TodoModel.self, from: data)
                    DispatchQueue.main.async {
                        if let index = self.todos.firstIndex(where: { $0.id == id }) {
                            self.todos[index] = updatedTodo
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    
    // Function to delete a Todo
        func deleteTodo(id: Int) {
            guard let url = URL(string: "\(url)/\(id)") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, _ in
                guard data != nil else {
                    print("No data returned")
                    return
                }
            }.resume()
        }
}

