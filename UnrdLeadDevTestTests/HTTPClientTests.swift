//
//  HTTPClientTests.swift
//  UnrdLeadDevTestTests
//
//  Created by Julian Ramkissoon on 28/10/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import UnrdLeadDevTest

final class URLSessionHTTPClient {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { (_, _, error) in
            if let error = error {
                 completion(.fail(error))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_FailsWhenRequestErrors() {
        URLProtocolStub.startInterceptingRequests()
        let sut = URLSessionHTTPClient()
        let anyURL = URL(string: "https://anyURL.com")!
        let expectedError = NSError(domain: "Test", code: 0)
            
        URLProtocolStub.stub(error: expectedError)

        let exp = expectation(description: "Wait for completion")

        sut.get(from: anyURL) { (result) in
            switch result {
            case let .fail(error as NSError):
                XCTAssertEqual(error, expectedError)
            default:
                XCTFail("Expected \(expectedError), got \(result) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        URLProtocolStub.stopInterceptingRequests()
    }
}

private class URLProtocolStub: URLProtocol {
    
    private static var stub: Stub?
    
    private struct Stub {
        let error: Error?
    }
    
    static func stub(error: Error) {
        stub = Stub(error: error)
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = URLProtocolStub.stub?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
    static func startInterceptingRequests() {
        URLProtocol.registerClass(URLProtocolStub.self)
    }

    static func stopInterceptingRequests() {
        URLProtocol.unregisterClass(URLProtocolStub.self)
        stub = nil
    }
}
