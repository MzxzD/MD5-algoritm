//
//  String + Extensions.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 22/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation

public extension String {
  
  /// Hashing algorithm for hashing a string instance.
  ///
  /// - Parameters:
  ///   - type: The type of hash to use.
  ///   - output: The type of output desired, defaults to .hex.
  /// - Returns: The requested hash output or nil if failure.
  func hashed(_ type: HashType, output: HashOutputType = .hex) -> String? {
    
    // convert string to utf8 encoded data
    guard let message = data(using: .utf8) else { return nil }
    return message.hashed(type, output: output)
  }
}

public extension String {
  
}
