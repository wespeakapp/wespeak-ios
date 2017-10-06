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
    //var provider: MoyaProvider<APIService> = MoyaProvider(endpointClosure: endPointClosure)
    
    
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
    
    func getUserInfo(completionHandle: @escaping (ResultType<User>) -> Void) {
        Provider.request(.GetUserInfo()){ result in
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