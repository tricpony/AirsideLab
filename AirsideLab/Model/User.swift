//
//  User.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation

struct User: Decodable {
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case profile = "html_url"
    }

    var username: String?
    var profileUrlString: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.profileUrlString = try container.decode(String.self, forKey: .profile)
    }
}
