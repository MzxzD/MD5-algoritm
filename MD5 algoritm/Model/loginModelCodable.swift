//
//  loginModelCodable.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation

// MARK: - LoginModel
struct LoginModelCodable: Codable {
  let loginModel: [LoginModelElement]
}

// MARK: - LoginModelElement
struct LoginModelElement: Codable {
  let id, name, role: String
  let avatarURL: String
  let passHash: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, role
    case avatarURL = "avatarUrl"
    case passHash
  }
}


func parseLocalJSON() -> LoginModelCodable? {
  
  if let path = Bundle.main.path(forResource: "data", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
    return SerializationManager.parseData(jsonData: data, toType: LoginModelCodable.self)
  } else {
    return nil
  }
}
