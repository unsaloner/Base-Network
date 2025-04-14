//
//  BaseNetworkDelegate.swift
//  BaseNetwork
//
//  Created by macbook on 14.04.2025.
//

import Foundation

public protocol BaseNetworkDelegate {
    func request<T: Decodable>(requestModel: BaseRequestModel,
                               responseType: T.Type,
                               completion: @escaping (Result<T, BaseNetworkError>) -> Void)
}
