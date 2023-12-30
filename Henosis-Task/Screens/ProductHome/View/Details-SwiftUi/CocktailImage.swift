//
//  CocktailImage.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import SwiftUI
import Kingfisher

struct CocktailImage: View {
    
    let imageURLString: String
    
    var body: some View {
        
        KFImage.url(URL(string: imageURLString))
            .resizable()
            .placeholder {
                ProgressView()
            }
            .onFailure { error in
                print("Error: \(error)")
            }
    }
}

struct CocktailImage_Previews: PreviewProvider {
    static var previews: some View {
        //default url
        CocktailImage(imageURLString: "https://www.onceuponachef.com/images/2023/07/pina-coladas.jpg")
    }
}
