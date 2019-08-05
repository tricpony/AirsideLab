//
//  JsonUtility.swift
//  DoorDashLab
//
//  Created by aarthur on 6/28/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation
import CoreData

/// Generic struct for parsing json
/// The generic type should be a decodable type that the parser will create and fill
struct JsonUtility<T: Decodable> {

    /// Parse the payload
    /// - Parameters:
    ///   - payload: JSON data
    /// - Returns: An array of generic type, T, objects, or nil
    static func parseJSON(_ payload: Data?) -> [T]? {
        if payload == nil {
            return nil
        }

        let decoder = JSONDecoder()

        do {
            let decoded = try decoder.decode([T].self, from: payload!)
            return decoded
        } catch let error {
            print(error)
        }
        return nil
    }
}
