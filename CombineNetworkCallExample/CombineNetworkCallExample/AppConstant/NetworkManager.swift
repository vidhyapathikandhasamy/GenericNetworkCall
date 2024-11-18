//
//  NetworkManager.swift
//  CombineNetworkCallExample
//
//  Created by Vidhyapathi on 17/11/24.
//

import Foundation

class NetworkManager {
    
    func makeNetWorkCall<T: Decodable>(url: URL, method: NetWorkVerbsEnum = .get, headers: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "NetworkError", code: -1, userInfo: [NSLocalizedDescriptionKey : "No data received."])))
                return
            }
            
            do {
                let decodeObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
