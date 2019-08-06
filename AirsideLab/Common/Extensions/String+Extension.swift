//
//  String+Extension.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation

extension String {
    var urlEncoded: String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else { return self }
        return encoded
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
}
