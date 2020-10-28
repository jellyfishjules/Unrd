//
//  HTTPClient.swift
//  UnrdLeadDevTest
//
//  Created by Julian Ramkissoon on 28/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data)
    case fail(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}


