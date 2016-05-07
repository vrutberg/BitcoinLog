//
//  Request_extension.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 20/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import Alamofire

protocol ResponseObjectSerializable {
    init(representation: AnyObject)
}

extension Alamofire.Request {
    func responseObject<T: ResponseObjectSerializable>(completionHandler: (Response<T,NSError>) -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T,NSError> {
            request, response, data, error in
            
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
                case .Success(let value):
                    let decodedObject = T(representation: value)
                    return .Success(decodedObject)
                case .Failure(let error):
                    return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}