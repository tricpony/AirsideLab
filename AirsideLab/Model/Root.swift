//
//  Root.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation

/// Struct to capture the root of the JSON where the git hub user array is nested
struct Root: Decodable {
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }

    var users: [User]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.users = try container.decode([User].self, forKey: .users)
    }
}
