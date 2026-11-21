//
//  ContentView.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    @State private var isDataAvailable = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.company)
    ]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if isDataAvailable {
                    UserList(sortOrder: sortOrder)
                } else {
                    ProgressView()
                }
            }
            .task {
                await loadData()
            }
            .navigationTitle("Fetch & Show Users")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func loadData() async {
        if !users.isEmpty {
            isDataAvailable = true
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let userList = try? decoder.decode([User].self, from: data) {
                for user in userList {
                    modelContext.insert(user)
                }
                isDataAvailable = true
            }
        } catch {
            print("Invalid Data")
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    ContentView()
}
