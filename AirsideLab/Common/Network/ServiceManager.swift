//
//  ServiceManager.swift
//  AirsideLab
//
//  Created by aarthur on 8/5/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import Foundation
import Alamofire

/// Struct to centralize service calls
struct ServiceManager {
    
    /// Invokes store search API service
    /// - Parameters:
    ///   - arg: Github user's name to search for
    ///   - completion: call back closure returning either service success with payload or failure
    /// - Returns: Returns the session manager
    func startGitHubSearchService(arg: String, completion:@escaping (Swift.Result<Data, Error>)->()) -> SessionManager? {
        guard let url = URL(string: API.endPoint) else { return nil }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(7)
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        sessionManager.startRequestsImmediately = false
        sessionManager.request(url,
                          method: .get,
                          parameters: ["q": arg],
                          encoding: NOURLEncoding())
            .validate()
            .responseData { response in
                guard response.result.isSuccess else {
                    completion(.failure(response.result.error!))
                    return
                }
                completion(.success(response.result.value!))
        }.resume()
        return sessionManager
    }
}

public struct NOURLEncoding: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        guard let parameters = parameters as? [String: String] else { return urlRequest }
        guard let arg = parameters.values.first else { return urlRequest }
        guard let serviceAddress = urlRequest.urlRequest?.url?.absoluteString else { return urlRequest }

        urlRequest.url = URL(string: serviceAddress + "?q=" + arg)
        return urlRequest
    }
}
