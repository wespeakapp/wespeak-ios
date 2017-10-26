//
//  ErrorHandle.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/6/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import SwiftyJSON
enum ResultType<T> {
    case success(T)
    case failure(ErrorType)
}

enum ErrorType {
    case NetworkError(statusCode: Int)
    case SwiftError(error: Error)
    case InternalError(error: WSError)
    public var message: String {
        switch self {
            case .NetworkError(let code):
                return "Network error: \(code)"
            case.SwiftError(let error):
                return "Error: \(error)"
            case .InternalError(let error):
                return "\(error.statusCode): \(error.message)"
        }
    }
}

struct WSError {
    var statusCode: Int
    var error: String
    var message: String
    
    init(json:JSON) {
        statusCode = json["statusCode"].intValue
        error = json["error"].stringValue
        message = json["message"].stringValue
    }
}


