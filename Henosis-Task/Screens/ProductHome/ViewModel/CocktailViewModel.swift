//
//  CocktailViewModel.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import Foundation

final class CocktailViewModel{
    
    private var products: [CocktailModel] = [] {
        didSet {
            products.sort { $0.name < $1.name }
        }
    }
    
    private var filteredCocktails: [CocktailModel] = []
    
    var eventHandler: ((Event) -> Void)?

    
    func productFeatch(){
        eventHandler?(.loading)
        APIManger.shared.fetchCocktailList { response in
            switch response {
            case .success(let products):
                self.products = products
                self.eventHandler?(.dataLoading)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    // Function to filter cocktails based on segment index
    func filterCocktails(forSegmentIndex index: Int) {
        switch index {
        case 0: // Show all cocktails
            filteredCocktails = products
        case 1: // Show only alcoholic cocktails
            filteredCocktails = products.filter { $0.type == .alcoholic }
        case 2: // Show only non-alcoholic cocktails
            filteredCocktails = products.filter { $0.type == .nonAlcoholic }
        default:
            filteredCocktails = products
        }
    }
    
    // Getter for the filtered cocktails
    func getFilteredCocktails() -> [CocktailModel] {
        return filteredCocktails
    }
    
}

extension CocktailViewModel {
    enum Event {
        case loading
        case dataLoading
        case error(Error)
    }
}
