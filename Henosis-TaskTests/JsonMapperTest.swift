//
//  JsonMapperTest.swift
//  Henosis-TaskTests
//
//  Created by pnkbksh on 30/12/23.
//

import Foundation
import XCTest
@testable import Henosis_Task

class JsonMapper:XCTestCase{
    
    func testCocktailModelJSONParsing() throws {
        
        guard let fileURL = Bundle.main.url(forResource: "sample", withExtension: "json") else {
                XCTFail("Failed to locate 'sample.json' in the app bundle")
                return
            }
            XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path), "File 'sample.json' does not exist")
        

        do {
            let jsonData = try Data(contentsOf: fileURL)
            let cocktailList  = try JSONDecoder().decode([CocktailModel].self, from: jsonData)
            
            
            XCTAssertNotNil(cocktailList , "cocktail response can not be in ")
            
            let cocktail = cocktailList[0]
            //change any of these value to make fail case.
            XCTAssertEqual(cocktail.id, "0")
            XCTAssertEqual(cocktail.name, "Piña colada")
            XCTAssertEqual(cocktail.type, .alcoholic)
            XCTAssertEqual(cocktail.preparationMinutes, 7)

            
        } catch {
            XCTFail("Failed to decode JSON: \(error.localizedDescription)")
        }

    }
    
}
