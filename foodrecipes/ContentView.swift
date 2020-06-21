//
//  ContentView.swift
//  foodrecipes
//
//  Created by Arik on 17/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import SwiftUI

struct FoodRecipesListView: View {
    
    let foods = [
        FoodModels(title: "Nasi Goreng", desc: "enak"),
        FoodModels(title: "Nasi Bakar", desc: "Sedap"),
    ]
    
    var body: some View {
        NavigationView{
            List(foods) { food in
                ItemView(model: food)
            }.navigationBarTitle("Food Recipeps")
        }
    }
}



struct ItemView: View {
    let model : FoodModels
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.headline)
            Text(model.desc)
                .font(.subheadline)
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecipesListView()
    }
}
