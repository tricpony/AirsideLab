//
//  URLImage.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation
import UIKit

typealias URLImageCompletion = (Swift.Result<UIImage?, Error>) -> Void

/// Fetches a UIImage from a URL asynchronously, calling the completion handler upon success or failure.
public struct URLImage {
    static let cache = NSCache<NSString, UIImage>()
    
    /// Fetches a UIImage from a URL asynchronously, calling the completion handler upon success or failure.
    ///
    /// - parameter url: The URL of an image to fetch
    /// - parameter completion: An escaping closure called on the Main thread with result
    static func fetchImageURL(_ url: URL, completion: @escaping URLImageCompletion) {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return
        }
        let requestSession = URLSession.shared
        let request = URLRequest(url: url)
        
        requestSession.dataTask(with: request) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            var imageFromURL: UIImage?
            if let data = data {
                imageFromURL = UIImage(data: data)
                if let cachedImage = imageFromURL {
                    cache.setObject(cachedImage, forKey: url.absoluteString as NSString)
                }
            }

            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(imageFromURL))
                }
            }
            }.resume()
    }
}
