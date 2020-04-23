//
//  SerializationManager.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation
class SerializationManager {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
  static func parseData<T: Codable>(jsonData: Data, toType: T.Type) -> T?{
        let object: T?
        do {
            object = try jsonDecoder.decode(T.self, from: jsonData)
            
        } catch let error {
            debugPrint("Error while parsing data from server. Received dataClassType: \(T.self). More info: \(error)")
            object = nil
        }
        return object
    }
}
