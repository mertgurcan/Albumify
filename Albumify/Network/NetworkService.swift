//
//  NetworkService.swift
//  Albumify
//
//  Created by Mert Gürcan on 12.02.2022.
//

import Foundation

/// Custom Error enum for handle different types of errors
public enum CustomError: Error {
    case parseError
    case serverError(_ error: Error)
    case responseNil
}

/// Service protocol that blueprint of our service class
public protocol ServiceProtocol {

    /// Aysnc network call handler
    ///  - Parameter resource: Owns essential parameters for network calls
    ///  - Returns: Result of our network call
    func load<T>(resource: Resource<T>, completion: @escaping(URLNetworkResponse<T?>) -> ())
}

/// Service class that created with service protocol
open class Service : ServiceProtocol {

    open func load<T>(resource: Resource<T>, completion: @escaping(URLNetworkResponse<T?>) -> ()) {
        URLSession.shared.dataTask(with: URL(string: resource.url)! ){ data,response,error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let device = try decoder.decode(T.self, from: data)
                    completion(.succes(device))
                } catch let err {
                    print(err)
                    completion(.failure(CustomError.parseError))
                }
            }
        }.resume()
    }

    public init() {
    }
}
