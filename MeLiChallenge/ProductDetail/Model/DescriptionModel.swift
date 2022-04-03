//
//  DescriptionModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 22/03/22.
//

import Foundation

struct DescriptionModel: Decodable {
    
    let plainText : String
    
    private enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}
