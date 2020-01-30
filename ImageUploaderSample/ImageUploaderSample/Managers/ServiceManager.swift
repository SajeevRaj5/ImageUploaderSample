//
//  ServiceManager.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation
typealias ServiceResponseBlock<T: Codable> = (ServiceResponse<T>) -> ()
typealias UploadResponseBlock = (Result<Data, Error>) -> Void

class ServiceManager {
    
    static let shared = ServiceManager()
        
    var dataTask: URLSessionDataTask?

    private init() {}
    
    func request<T>(request: URLRequest, completion: ServiceResponseBlock<T>?) where T: Codable {
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion?(.finally)

            if let error = error {
                completion?(.failure(error: error))
                return
            }
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion?(.failure(error: error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                completion?(.success(data: responseData))
                
            } catch let error {
                print("Error", error)
                completion?(.failure(error: error))
            }
        }.resume()
    }
    
    func uploadRequest(request: URLRequest,data: Data, completion: UploadResponseBlock?) {
        URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in
            //  completion?(.finally)
            
            if let error = error {
                completion?(.failure(error))
                return
            }
            guard let _ = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                completion?(.failure(error))
                return
            }
            
            do {
                completion?(.success(data))
            }
            catch let error {
                print("Error", error)
                completion?(.failure(error))
            }
        }.resume()
    }
}

extension ServiceManager {
    struct API {
        static var baseUrl: URL? {
            return URL(string: "https://api.cloudinary.com/v1_1/")
        }
    }
}

enum HTTPMethod: String {
    case get
    case post
    case update
    case delete
}

enum ContentType {    
    case normal
    case multipart(data: Data)
}
