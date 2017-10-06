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
let Provider = MoyaProvider<APIService>(endpointClosure: endPointClosure)

enum APIService {
    case LoginFB(token: String)
    case GetUserInfo()
}

extension APIService: TargetType {
    var baseURL: URL { return URL(string:"http://35.188.157.198:3000/api/v1/")!}
    
    public var path: String {
        switch self {
        case .LoginFB(_):
            return "login"
        case .GetUserInfo():
            return "user/profile"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .LoginFB(_):
            return .get
        case .GetUserInfo():
            return .get
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
