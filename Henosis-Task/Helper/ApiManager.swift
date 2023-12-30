//
//  ApiManager.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import Foundation
import UIKit

enum DataError:Error{
    case invalidPath
    case invalidResposne
    case invalidURL
    case invalidData
    case network(Error?)
    
}

typealias Handler = (Result<[CocktailModel] , DataError>) ->Void

//Singletone design Pattern
//final :- no inheritance of APIManger
final class APIManger{
    
    static  let shared = APIManger()
    
    private  init() {
        //capital Singletone use init private no one should create object outside class
    }
    
    //result  contain-- success and error
    func fetchCocktailList(completion:@escaping Handler){
        // Get the file path of the JSON file in your app bundle
        guard let path = Bundle.main.path(forResource: "sample", ofType: "json") else {
            completion(.failure(.invalidPath)) // if path given wrong..
            fatalError("Failed to locate :---> 'sample.json' in the app bundle...")
        }

        // Convert  file path to a URL.....
        let fileURL = URL(fileURLWithPath: path)

        do {
            // Read JSON data from the file...
            let jsonData = try Data(contentsOf: fileURL)

            // Decode the JSON data into an array of CocktailModel
            let cocktailProductList = try JSONDecoder().decode([CocktailModel].self, from: jsonData)
            completion(.success(cocktailProductList))

            
        } catch {
            print("Error decoding JSON:", error)
            completion(.failure(.network(error)))
        }
    }

}
