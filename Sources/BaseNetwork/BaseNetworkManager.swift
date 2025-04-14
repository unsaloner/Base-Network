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

        session.request(urlString,
                        method: requestModel.method,
                        parameters: requestModel.parameters,
                        encoding: requestModel.encoding,
                        headers: requestModel.headers)
        .validate()
        .responseData { response in
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
                completion(.failure(.decoding))
            }
        case .failure:
            let code = response.response?.statusCode
            let message = HTTPURLResponse.localizedString(forStatusCode: code ?? 500)
            completion(.failure(BaseNetworkError(message: message, code: code)))
        }
    }
}
