//
//  URLSessionHTTPClient.swift
//  Unrd
//
//  Created by Julian Ramkissoon on 29/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedResponse: Error {}

    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.fail(error))
            } else if let data = data {
                completion(.success(data))
            }  else {
                completion(.fail(UnexpectedResponse()))
            }
        }.resume()
    }
}
