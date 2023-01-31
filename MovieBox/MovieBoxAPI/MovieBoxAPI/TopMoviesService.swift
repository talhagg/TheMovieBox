//
//  TopMoviesService.swift
//  MovieBoxAPI
//
//  Created by Talha Gölcügezli on 21.01.2023.
//

import Foundation
import Alamofire

public protocol TopMoviesServiceProtocol {
    func fetchMovies(url: String, completion: @escaping(Result<[Movies],Error>) -> Void)
}


public class TopMoviesService : TopMoviesServiceProtocol {
    
    public enum CaseError : Error {
        case serializationError
        case networkError
    }
    
    public init() {}
    
    public func fetchMovies(url: String, completion: @escaping (Result<[Movies],Error>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.plaindDateDecoder
                do {
                    let values = try decoder.decode(TopMoviesResponse.self, from: data)
                    let movies = values.result
                    completion(.success(movies))
                } catch {
                    completion(.failure(CaseError.serializationError))
                }
            case .failure(let error):
                completion(.failure(CaseError.networkError))
            }
        }
    }
    
    
}
