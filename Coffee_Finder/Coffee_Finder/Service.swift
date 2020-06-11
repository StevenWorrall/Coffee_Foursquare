//
//  Service.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/9/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import Foundation

class Service {
    public func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping ((Result<T, Error>) -> () )) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let data = data else { return }
//            print("JSON String: \(String(data: data, encoding: .utf8))")

            do {
                let dataResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataResponse))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}
