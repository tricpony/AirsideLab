//
//  String+Extension.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation

extension String {
    /// Make string url ready
    /// - Returns: url encoded copy of self
    var urlEncoded: String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else { return self }
        return encoded
    }
    
    /// Remove leading and trailing spaces
    /// - Returns: Copy of self with no leading or trailing spaces
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
}
