//
//  User.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation

struct User: Decodable {
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case profile = "html_url"
        case score
        case avatarUrl = "avatar_url"
    }

    var userName: String
    var profileUrlString: String
    var score: Float
    var avatar: String
    var displayUsername: String {
        return "Login: " + userName
    }
    var displayScore: String {
        return "Score: " + String(score)
    }
    var avatarUrl: URL? {
        return URL(string: avatar)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.profileUrlString = try container.decode(String.self, forKey: .profile)
        self.avatar = try container.decode(String.self, forKey: .avatarUrl)
        self.score = try container.decode(Float.self, forKey: .score)
    }
}
