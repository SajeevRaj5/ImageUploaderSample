//
//  GalleryItem.swift
//  ImageUploaderSample
//
//  Created by Sajeev on 1/27/20.
//  Copyright © 2020 ImageUploaderSample. All rights reserved.
//

import Foundation

class GalleryItem: Codable {
    let bytes : Int?
    let format : String?
    let height : Int?
    let type : String?
    let url : String?
    let version : Int?
    let width : Int?
    
    static func getAllImages(index: String, completion: @escaping (ServiceResponse<GalleryResponse>) -> ()) {
        Router.images(index: index).request { (response: ServiceResponse<GalleryResponse>) in
            switch response {
            case .success(let result):
                completion(.success(data: result))
            case .failure(let error):
                completion(.failure(error: error))
            case .finally:
                completion(.finally)
            }
        }
    }
}

extension GalleryItem {
    enum Router: Requestable {
        case images(index: String)
        
        var path: String {
            return "resources/image"
        }
        
        var parameters: [String : String] {
            switch self {
            case .images(let nextPageIndex):
                return ["next_cursor": nextPageIndex]
            }
        }
    }
}

class GalleryResponse: Codable {
    let nextIndex : String?
    let resources : [GalleryItem]?


    enum CodingKeys: String, CodingKey {
        case nextIndex = "next_cursor"
        case resources = "resources"
    }
}
