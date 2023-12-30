//
//  ConktailModel.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import Foundation


struct CocktailModel: Codable {
    let id, name, shortDescription, longDescription, imageName: String
    let type: TypeEnum
    let preparationMinutes: Int
    let ingredients: [String]
}


enum TypeEnum: String, Codable {
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}
