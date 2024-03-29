//
//  Struct.swift
//  Merch
//
//  Created by Burak Erdem on 9.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import Foundation

struct AuthToken: Codable {
    let authToken: String
    
    init(authToken: String!) {
        self.authToken = authToken
    }
}

struct UserProfile: Codable {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let company_id: Int
    let user_type: String
    let status: String
    
    init(id: Int,
         firstname: String,
         lastname: String,
         email: String,
         company_id: Int,
         user_type: String,
         status: String) {
        
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.company_id = company_id
        self.user_type = user_type
        self.status = status
        
    }
    
    
}

struct StoreDataRoute: Codable {
    
    let store_id: Int
    let store_name: String
    let store_lat: String
    let store_long: String
    
    init(store_id: Int, store_name: String, store_lat: String, store_long: String) {
        self.store_id = store_id
        self.store_name = store_name
        self.store_lat = store_lat
        self.store_long = store_long
    }
    
}

struct RoutePlan: Codable {
    let date: String
    let start_time: String
    let end_time: String
    let dateAndTime: String
    let store: StoreDataRoute
    
    init(date: String, start_time: String, end_time: String, dateAndTime: String, store: StoreDataRoute) {
        self.date = date
        self.start_time = start_time
        self.end_time = end_time
        self.dateAndTime = dateAndTime
        self.store = store
        
    }
}


extension testUser: Decodable {
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case id = "id"
        case username = "username"
        case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
        let id: Int = try container.decode(Int.self, forKey: .id) // extracting the data
        let username: String = try container.decode(String.self, forKey: .username) // extracting the data
        let email: String = try container.decode(String.self, forKey: .email)
        
        self.init(id: id, username: username, email: email) // initializing our struct
    }
    
    
}

/*extension UserProfile: Decodable {
    enum UserProfileStructKeys: String, CodingKey {
        case id = "id"
        case firstname = "firstname"
        case lastname = "lastname"
        case email = "email"
        case company_id = "company_id"
        case user_type = "user_type"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserProfileStructKeys.self) // defining our (keyed) container
        
        let id: Int = try container.decode(Int.self, forKey: .id) // extracting the data
        let firstname: String = try container.decode(String.self, forKey: .firstname) // extracting the data
        let lastname: String = try container.decode(String.self, forKey: .lastname) // extracting the data
        let email: String = try container.decode(String.self, forKey: .email) // extracting the data
        let company_id: Int = try container.decode(Int.self, forKey: .company_id) // extracting the data
        let user_type: String = try container.decode(String.self, forKey: .user_type) // extracting the data
        let status: String = try container.decode(String.self, forKey: .status) // extracting the data
        
        
        self.init(id: id, firstname: firstname, lastname: lastname, email: email, company_id: company_id, user_type: user_type, status: status)
        
    }
}*/


struct testUser {
    let id: Int
    let username: String
    let email: String
    
    init(id: Int, username: String, email: String) { // default struct initializer
        self.id = id
        self.username = username
        self.email = email
    }
}
