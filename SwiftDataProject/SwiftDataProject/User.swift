//
//  User.swift
//  SwiftDataProject
//
//  Created by Kelsey Steven on 11/19/26.
//

import Foundation
import SwiftData


@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

//Same but with jobs from day 58
//@Model
//class User {
//    var name: String
//    var city: String
//    var joinDate: Date
//    var jobs = [Job]()
//    
//    init(name: String, city: String, joinDate: Date, jobs: [Job]) {
//        self.name = name
//        self.city = city
//        self.joinDate = joinDate
//        self.jobs = jobs
//    }
//}
