//
//  API.swift
//  e-commerce-8x8
//
//  Created by Cosmin Cosan - on 05.09.2024.
//

import Foundation
import Alamofire

final class API {
    
    static func request<T: Decodable>(
        method: HTTPMethod,
        path: String,
        headers: [String: String] = [:],
        params: Parameters? = nil,
        of type: T.Type
    ) async throws -> T {
        // Set Encoding
        var encoding: ParameterEncoding = JSONEncoding.default
        
        switch method {
        case .post:
            encoding = JSONEncoding.default
        case .get:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
        }

        let url = Constants.serverBaseURL + path
        
        /// You must resume the continuation exactly once
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: HTTPHeaders(headers)
            ).responseDecodable(of: type) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)

                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
