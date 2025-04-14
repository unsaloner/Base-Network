//
//  BaseNetworkError.swift
//  BaseNetwork
//
//  Created by Unsal Oner on 14.04.2025.
//

import Foundation

public struct BaseNetworkError: Error {
    public let message: String
    public let code: Int?

    public init(message: String, code: Int? = nil) {
        self.message = message
        self.code = code
    }

    public static let unknown = BaseNetworkError(message: "Bilinmeyen bir hata oluştu")
    public static let decoding = BaseNetworkError(message: "Veri çözümlenemedi")
    public static let invalidURL = BaseNetworkError(message: "Geçersiz URL")
}
