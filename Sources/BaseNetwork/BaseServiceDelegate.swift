//
//  BaseServiceDelegate.swift
//  BaseNetwork
//
//  Created by macbook on 14.04.2025.
//

import Foundation

public protocol BaseServiceDelegate: AnyObject {
    var networkManager: BaseNetworkDelegate { get }
}

