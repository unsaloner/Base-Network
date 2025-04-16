//
//  BaseNetworkManager.swift
//  BaseNetwork
//
//  Created by Unsal Oner on 14.04.2025.
//

import Alamofire
import Foundation

public class BaseNetworkManager: BaseNetworkDelegate {

    private let session: Session

    public init(session: Session = .default) {
        self.session = session
    }
}

public extension BaseNetworkManager {

    func request<T: Decodable>(requestModel: BaseRequestModel,
                               responseType: T.Type,
                               completion: @escaping (Result<T, BaseNetworkError>) -> Void) {

        let urlString = requestModel.baseURL + requestModel.path

        logRequest(url: urlString, requestModel: requestModel)

        session.request(urlString,
                        method: requestModel.method,
                        parameters: requestModel.parameters,
                        encoding: requestModel.encoding,
                        headers: requestModel.headers)
        .validate()
        .responseData { response in
            self.logResponse(response)
            self.parseResponse(response, completion: completion)
        }
    }

    func parseResponse<T: Decodable>(_ response: AFDataResponse<Data>,
                                     completion: @escaping (Result<T, BaseNetworkError>) -> Void) {
        switch response.result {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("❌ Decode hatası: \(error)")
                let raw = String(data: data, encoding: .utf8) ?? "Yok"
                print("📦 Gelen veri:\n\(raw)")
                completion(.failure(.decoding))
            }
        case .failure:
            let code = response.response?.statusCode
            let message = HTTPURLResponse.localizedString(forStatusCode: code ?? 500)
            completion(.failure(BaseNetworkError(message: message, code: code)))
        }
    }

    private func logRequest(url: String, requestModel: BaseRequestModel) {
        print("""
        🔹 [NETWORK REQUEST]
        ▶️ URL: \(url)
        ▶️ Method: \(requestModel.method.rawValue)
        ▶️ Headers: \(requestModel.headers?.dictionary ?? [:])
        ▶️ Parameters: \(requestModel.parameters ?? [:])
        """)
    }

    private func logResponse(_ response: AFDataResponse<Data>) {
        let status = response.response?.statusCode ?? -1
        let url = response.request?.url?.absoluteString ?? "N/A"
        let dataString = String(data: response.data ?? Data(), encoding: .utf8) ?? "empty"

        print("""
        🔸 [NETWORK RESPONSE]
        ✅ Status: \(status)
        ✅ URL: \(url)
        ✅ Response Body: \(dataString)
        """)
    }
}
