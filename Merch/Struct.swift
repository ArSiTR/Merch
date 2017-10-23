//
//  Struct.swift
//  Merch
//
//  Created by Burak Erdem on 9.10.2017.
//  Copyright © 2017 Burak Erdem. All rights reserved.
//

import Foundation


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
