//
//  BaseRequestModel.swift
//  BaseNetwork
//
//  Created by macbook on 14.04.2025.
//

import Alamofire

public struct BaseRequestModel {
    public let baseURL: String
    public let path: String
    public let method: HTTPMethod
    public let headers: HTTPHeaders?
    public let parameters: Parameters?
    public let encoding: ParameterEncoding

    public init(baseURL: String,
                path: String,
                method: HTTPMethod = .get,
                headers: HTTPHeaders? = nil,
                parameters: Parameters? = nil,
                encoding: ParameterEncoding = URLEncoding.default) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}


