//
//  ApiClient.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/6/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//
import Moya
import SwiftyJSON

class APIManager {
    
    static let shareInstance = APIManager()
    
    func loginFB(token:String, completionHandle: @escaping (ResultType<String>) -> Void) {
        Provider.request(.LoginFB(token: token)) {
            result in
            switch result {
            case .success(let response):
                let data = response.data
                let json = JSON(data)
                if let token = json["access_token"].string {
                    Token.token = token
                    completionHandle(ResultType.success(token))
                } else {
                    completionHandle(ResultType.failure(ErrorType.NetworkError(statusCode: 400)))
                }
                break
            case .failure(let error):
                completionHandle(ResultType.failure(ErrorType.SwiftError(error: error)))
                break
            }
        }
    }
    
    func getUser(completionHandle: @escaping (ResultType<User>) -> Void) {
        Provider.request(.GetUser()){ result in
            switch result {
            case let .success(response):
                guard let data = JSON(response.data)["data"].dictionaryObject else {
                    //error
                    let statusCode = JSON(response.data)["statusCode"].intValue
                    let error = JSON(response.data)["error"].stringValue
                    let message = JSON(response.data)["message"].stringValue
                    print("\(statusCode): \(message)")
                    let wsError = WSError(statusCode: statusCode, error: error, message: message)
                    completionHandle(ResultType.failure(ErrorType.InternalError(error: wsError)))
                    return
                }
                
                let user = User.fromJSON(json: data)
                completionHandle(ResultType.success(user))
                break
            case let .failure(error):
                completionHandle(ResultType.failure(ErrorType.SwiftError(error: error)))
                break
            }
        }
    }
    
    func updateUser(user:User, completionHandle: @escaping (ResultType<User>) -> Void) {
        Provider.request(.UpdateUser(user: user)) {
            result in
            switch result {
            case let .success(response):
                let data = JSON(response.data)["data"].dictionaryObject
                let user = User.fromJSON(json: data!)
                completionHandle(ResultType.success(user))
                break
            case let .failure(error):
                completionHandle(ResultType.failure(ErrorType.SwiftError(error: error)))
                break
            }
        }
    }
}
