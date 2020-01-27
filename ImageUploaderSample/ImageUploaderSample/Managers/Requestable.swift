//
//  Requestable.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation
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
    var parameters: [String: String] { get }
    
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
    
    var queryParameters: [(queryName: String, queryValue: String)]? {
        return nil
    }
    
    var parameters: [String: String] {
        return [:]
    }
}

extension Requestable {
    func request<T: Codable>(completion: ServiceResponseBlock<T>?) {
        guard var components = URLComponents(string: ServiceManager.API.baseUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        
        // add parameters to url
        let urlQueryItems = parameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
        components.queryItems = urlQueryItems
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        // set http method. By default, method is GET
        request.httpMethod = method.rawValue.uppercased()
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        ServiceManager.shared.request(request: request, completion: completion)
    }
}
