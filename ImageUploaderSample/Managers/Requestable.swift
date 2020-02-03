//
//  Requestable.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import UIKit
enum ServiceResponse<T: Codable> {
    case success(data: T)
    case failure(error: Error)
    case finally
}

// protocol for parameters and path
protocol Requestable {
    
    // url path
    var path: String { get }
    
    // required parameters
    var parameters: [String: Any]? { get }
    
    // query parameters
    var queryParameters: [String: String]? { get }
    
    // http method
    var method: HTTPMethod { get }
        
    // request
    func request<T: Codable>(completion: ServiceResponseBlock<T>?)
    
}

extension Requestable {
    
    // setting GET by default
    var method: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

extension Requestable {
    func request<T: Codable>(completion: ServiceResponseBlock<T>?) {
        let combinedUrl = ServiceManager.API.baseUrl?.appendingPathComponent(Configuration.current.cloudName)
        guard var components = URLComponents(string: combinedUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        
        // add parameters to url
        if let allQueryParameters = queryParameters {
            let urlQueryItems = allQueryParameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
            components.queryItems = urlQueryItems
        }
        guard let url = components.url else { return }
        var request = URLRequest(url: url)

        // set http method. By default, method is GET
        request.httpMethod = method.rawValue.uppercased()
        
        if let allParameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: allParameters, options: .prettyPrinted)
                request.httpBody = data
            }
            catch {
              print("Unable to encode parameters")
            }
        }
        
        // set headers
        for (key, value) in defaultHeaders() {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        ServiceManager.shared.request(request: request, completion: completion)
    }
    
    func defaultHeaders() -> [String: String] {
        let credentialData = "\(Configuration.current.user):\(Configuration.current.password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        
        let headers = [
            "Authorization": "Basic \(base64Credentials)",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        return headers
    }
    
}
