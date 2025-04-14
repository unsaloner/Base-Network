//
//  BaseService.swift
//  BaseNetwork
//
//  Created by macbook on 14.04.2025.
//

open class BaseService: BaseServiceDelegate {
    
   public var networkManager: BaseNetworkDelegate
    
    public init(networkManager: BaseNetworkManager) {
        self.networkManager = networkManager
    }
}
