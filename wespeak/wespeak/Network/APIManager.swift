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
                    completionHandle(.success(token))
                } else {
                    completionHandle(.failure(ErrorType.InternalError(error: WSError(json: json))))
                }
                break
            case .failure(let error):
                completionHandle(.failure(ErrorType.SwiftError(error: error)))
                break
            }
        }
    }
    
    func getUser(completionHandle: @escaping (ResultType<User>) -> Void) {
        Provider.request(.GetUser()){ result in
            switch result {
            case let .success(response):
                guard let data = JSON(response.data)["data"].dictionaryObject else {
                    let json = JSON(response.data)
                    let wsError = WSError(json: json)
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
