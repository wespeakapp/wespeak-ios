//
//  APIService.swift
//  wespeak
//
//  Created by Quoc Huy Ngo on 10/6/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import Foundation
import Alamofire
import Moya

typealias TargetType = Moya.TargetType
typealias Method = Moya.Method

let Provider = MoyaProvider<APIService>(endpointClosure: endPointClosure)

enum APIService {
    //user info
    case LoginFB(token: String)
    case GetUser()
    case UpdateUser(user: User)
    
    //conversation
    case Find()
    case StopConversationBy(id: String)
    case GetConversationBy(id: String)
}

extension APIService: TargetType {
    var baseURL: URL { return URL(string:"http://35.188.157.198:3000/api/v1/")!}
    
    public var path: String {
        switch self {
        //User Info
        case .LoginFB(_):
            return "login"
        case .GetUser():
            return "user/profile"
        case .UpdateUser(_):
            return "user"
            
        //Conversation
        case .Find():
            return "conversation/find"
        case .StopConversationBy(let id):
            return "conversation/\(id)/stop"
        case .GetConversationBy(_):
            return "conversation"
        }
    }
    
    public var method: Method {
        switch self {
        case .LoginFB(_):
            return .get
        case .GetUser():
            return .get
        case .UpdateUser(_):
            return .put
            
        case .Find():
            return .post
        case .StopConversationBy(_):
            return .put
        case .GetConversationBy(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        switch self {
        case .LoginFB(let token):
            return .requestParameters(parameters: ["accessToken":token], encoding: URLEncoding.default)
        case .UpdateUser(let user):
            var params = [String:String]()
            if !user.name.isEmpty {
                params["name"] = user.name
            }
            if !user.about.isEmpty {
                params["about"] = user.about
            }
            if !user.nativeLanguage.isEmpty {
                params["nativeLanguage"] = user.nativeLanguage
            }
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .StopConversationBy(_):
            let params = ["status":"stop"]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .GetConversationBy(let id):
            let params = ["conversationId": id]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
}

let endPointClosure = { (target: APIService) -> Endpoint<APIService> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<APIService> = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task)
    switch target {
    case .LoginFB:
        return endpoint
    default:
        return endpoint.adding(newHTTPHeaderFields: ["Authorization" : "Bearer \(Token.token!)"])
    }
}
