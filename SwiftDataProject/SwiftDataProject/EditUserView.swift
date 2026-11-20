//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Kelsey Steven on 11/19/26.
//

import SwiftUI
import SwiftData


struct EditUserView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var user: User
    
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            // In practice we should wait until an object is necessary
            // before creating it. As is, we may see a flash of the
            // empty row on the previous screen before the delete ends
            if user.name.isEmpty || user.city.isEmpty {
                modelContext.delete(user)
            }
        }
    }
}

#Preview(traits: .modifier(SampleData())) {
    @Previewable @Query var users: [User]
    EditUserView(user: users.first!)
}
