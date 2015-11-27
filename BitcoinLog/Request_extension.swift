//
//  Request_extension.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 20/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import Foundation
import Alamofire

@objc public protocol ResponseObjectSerializable {
    init?(representation: AnyObject)
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (Response<T,NSError>) -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T,NSError> {
            request, response, data, error in
            
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
                case .Success(let value):
                    if let JSON = T(representation: value) {
                        return .Success(JSON)
                    } else {
                        let failureReason = "JSON could not be serialized into response object \(value)"
                        let error =  Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                        return .Failure(error)
                    }
                case .Failure(let error):
                    return .Failure(error)
                
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}