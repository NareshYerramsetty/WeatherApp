//
//  Network+Helper.swift
//  WeatherApp
//
//  Created by Naresh on 10/04/23.
//

import Foundation

protocol NetworkProtocol {
    
    func request<T: Codable>(urlString: String, model: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void)
}
