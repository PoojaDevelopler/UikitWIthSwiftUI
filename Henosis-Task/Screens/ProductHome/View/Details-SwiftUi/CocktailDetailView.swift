//
//  CocktailDetailView.swift
//  Henosis-Task
//
//  Created by pnkbksh on 29/12/23.
//

import SwiftUI

struct CocktailDetailView: View {
    
    let cocktail: CocktailModel
    @State private var showingAlert = false
    @State private var isHeartClicked = false
    @State private var isThumbUpClicked = false
    @State private var isThumbDownClicked = false
    
    var alertMessage: String {
        if isThumbUpClicked {
            return "You liked it! Thanks for your feedback."
        } else if isThumbDownClicked {
            return "You disliked it! We'll improve."
        } else {
            return ""
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                
                VStack {
                    
                    CocktailImage(imageURLString: cocktail.imageName)
                        .frame(height: geometry.size.height * 0.4) // 40% of screen height
                        .aspectRatio(contentMode: .fit)
                    
                    
                    Text(cocktail.longDescription)
                        .padding()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)

                       
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Feedback"),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isThumbDownClicked.toggle()
                            
                            if isThumbDownClicked {
                                isThumbUpClicked = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showingAlert = true
                            }
                        }) {
                            Image(systemName: isThumbDownClicked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                                .foregroundColor(isThumbDownClicked ? .primary : .gray)
                                .font(.system(size: 30))
                        }
                        
                        
                        Spacer()
                        Button(action: {
                            isThumbUpClicked.toggle()
                            
                            if isThumbUpClicked {
                                isThumbDownClicked = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showingAlert = true
                            }
                        }) {
                            Image(systemName: isThumbUpClicked ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .foregroundColor(isThumbUpClicked ? .red : .gray)
                                .font(.system(size: 30))
                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Life's too short to drink bad cocktails\nHappy New Year 2024")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationBarTitle(Text(cocktail.name))
    }
    
    
    
}

struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyModel =  CocktailModel(id: "2", name: "Virgin Pina Colada", shortDescription: "Non-alcoholic", longDescription: "A delicious mocktail", imageName: "pina_colada.jpg", type: .alcoholic, preparationMinutes: 7, ingredients: [])
        CocktailDetailView(cocktail: dummyModel)
    }
}
