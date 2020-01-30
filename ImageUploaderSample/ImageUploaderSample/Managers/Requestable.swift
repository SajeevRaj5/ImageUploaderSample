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
    var parameters: [String: String]? { get }
    
    // http method
    var method: HTTPMethod { get }
    
    // content type
    var contentType: ContentType { get }
        
    // request
    func request<T: Codable>(completion: ServiceResponseBlock<T>?)
    
    // upload request
    func uploadRequest(image: UIImage, completion: UploadResponseBlock?)
}

extension Requestable {
    
    // setting GET by default
    var method: HTTPMethod {
        return .get
    }
    
    var contentType: ContentType {
        return .normal
    }
    
    var queryParameters: [(queryName: String, queryValue: String)]? {
        return nil
    }
    
    var parameters: [String: String]? {
        return nil
    }
}

extension Requestable {
    func request<T: Codable>(completion: ServiceResponseBlock<T>?) {
        let combinedUrl = ServiceManager.API.baseUrl?.appendingPathComponent(Configuration.cloudName)
        guard var components = URLComponents(string: combinedUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        
        // add parameters to url
        if let allParameters = parameters {
            let urlQueryItems = allParameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
            components.queryItems = urlQueryItems
        }
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        // set http method. By default, method is GET
        request.httpMethod = method.rawValue.uppercased()
        
        // set headers
        for (key, value) in defaultHeaders() {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        ServiceManager.shared.request(request: request, completion: completion)
    }
    
    func uploadRequest(image: UIImage, completion: UploadResponseBlock?) {
        guard let imageData = image.pngData() else { return }
        let combinedUrl = ServiceManager.API.baseUrl?.appendingPathComponent(Configuration.cloudName)
        guard var components = URLComponents(string: combinedUrl?.appendingPathComponent(path).absoluteString ?? "") else { return }
        let clouldPresentParameters = ["upload_preset": "dkcsv4kwt"]
        let data = buildUploadedData(withResourceData: imageData, boundaryConstant: UUID().uuidString, parameters: clouldPresentParameters)
        
        // add parameters to url
        if let allParameters = parameters {
            let urlQueryItems = allParameters.map{ return URLQueryItem(name: $0.0, value: $0.1) }
            components.queryItems = urlQueryItems
        }
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        
        // set http method. By default, method is GET
        request.httpMethod = method.rawValue.uppercased()
        
        // set headers
        for (key, value) in defaultHeaders() {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        ServiceManager.shared.uploadRequest(request: request, data: data, completion: completion)
    }
    
    private func buildUploadedData(withResourceData resourceData: Data, boundaryConstant: String, parameters: [String: Any]) -> Data {
        var data = Data()
        //swiftlint:disable force_unwrapping
        data.append("\r\n--\(boundaryConstant)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(resourceData)
        
        for (key, value) in parameters {
            data.append("\r\n--\(boundaryConstant)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: .utf8)!)
        }
        
        data.append("\r\n--\(boundaryConstant)--\r\n".data(using: .utf8)!)
        //swiftlint:enable force_unwrapping
        
        return data
    }
    
    func defaultHeaders() -> [String: String] {
        let credentialData = "\(Configuration.user):\(Configuration.password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        
        let headers = [
                    "Authorization": "Basic \(base64Credentials)",
                    "Accept": "application/json",
                    "Content-Type": "application/json" ]
        return headers
    }
}
