//
//  BaseService.swift
//  MoviesTest
//
//  Created by Camilo López on 5/15/19.
//  Copyright © 2019 Camilo López. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResponse {
    case success(response: Data, headers: [AnyHashable: Any])
    case failure
    case notConnectedToInternet
    case expiredToken
    case reauthenticationRequired
}

class BaseService {
    
    func callEndpoint(endPoint: String, method: Alamofire.HTTPMethod = .get, page: Int = 0, headers: [String:String]? = [:], params: [String : Any]? = [:], timeout: Double = Constants.RequestTimeOutConstants.defaultTimeOut, completion:@escaping (ServiceResponse) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.token)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(endPoint, headers: headers).responseString { response in
            
            guard let urlResponse = response.response else {
                if let error = response.result.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    completion(.notConnectedToInternet)
                } else {
                    completion(.failure)
                }
                return
            }
            
            switch urlResponse.statusCode {
            case 200:
                guard let responseData = response.result.value!.description.data(using: .utf8) else {
                    completion(.failure)
                    return
                }
                completion(.success(response: responseData, headers: [:]))
            case NSURLErrorNotConnectedToInternet:
                completion(.notConnectedToInternet)
            default:
                completion(.failure)
            }
        }
    }
}
