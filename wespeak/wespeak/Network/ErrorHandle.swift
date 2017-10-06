//
//  ErrorHandle.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/6/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

enum ResultType<T> {
    case success(T)
    case failure(ErrorType)
}

enum ErrorType {
    case NetworkError(statusCode: Int)
    case SwiftError(error: Error)
    public var message: String {
        switch self {
            case .NetworkError(let code):
                return "Network error: \(code)"
            case.SwiftError(let error):
                return "Error: \(error)"
        }
    }
}


