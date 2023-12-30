//
//  IngridientList.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import SwiftUI

struct IngridientList: View {
    @State var cocktailList: [String]
    @State var cocktailName:String
    
    
    var body: some View {
            List {
                Section(header: Text("\(cocktailName) Ingredients")) {
                    
                    ForEach(cocktailList, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)

                            Text("\(ingredient)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)

                    }
                }
                .font(.headline)
                .foregroundColor(.primary)
                .bold()
            }
            .listStyle(InsetGroupedListStyle())
        }
}

struct IngridientList_Previews: PreviewProvider {
    static var previews: some View {
        
        let dummyModel = ["test1" , "test2" , "test3" , "test4"]
        IngridientList(cocktailList: dummyModel,  cocktailName: "myCocktail")
    }
}
