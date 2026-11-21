//
//  User.swift
//  UserChallenge
//
//  Created by Kelsey Steven on 11/20/26.
//

import Foundation
import SwiftData


@Model
class User: Codable {
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case registered
        case name
        case age
        case company
        case email
        case address
        case about
        case tags
        case friends
    }
    
    
    var id: String
    var isActive: Bool
    var registered: Date
    
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    
    var tags: [String]
    @Relationship(deleteRule: .cascade) var friends: [Friend]
    
    
    init(id: String, isActive: Bool, registered: Date, name: String,
         age: Int, company: String, email: String, address: String,
         about: String, tags: [String], friends: [Friend]) {
        
        self.id = id
        self.isActive = isActive
        self.registered = registered
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.tags = tags
        self.friends = friends
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        registered = try container.decode(Date.self, forKey: .registered)

        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(registered, forKey: .registered)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }
}


@Model
class Friend: Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    var id: String
    var name: String
    
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .name)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

