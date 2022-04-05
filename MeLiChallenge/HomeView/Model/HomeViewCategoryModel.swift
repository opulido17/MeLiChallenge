//
//  HomeViewCategoryModel.swift
//  MeLiChallenge
//
//  Created by Orlando Pulido Marenco on 29/03/22.
//

import Foundation

struct CategoryModel: Decodable {
    let id: String
    let name: String
    
    static func getModelCategoryBasic(id: String) -> CategoryModel {
        return CategoryModel(id: id, name: id)
    }
}
