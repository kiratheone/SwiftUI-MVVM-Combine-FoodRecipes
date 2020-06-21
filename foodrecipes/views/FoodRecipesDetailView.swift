//
//  FoodRecipesDetailView.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import SwiftUI
import URLImage

struct FoodRecipesDetailView: View {
    let food : FoodModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FoodsImageVIew(url: URL(string: food.image)!)
                Text("Recipe : ")
                    .font(.title)
                    .padding()
                Text(food.desc)
                    .font(.subheadline)
                    .padding()
                Spacer()
                
                
            }
        }
        .navigationBarTitle(food.name)
    }
}

struct FoodsImageVIew : View{
    let url :URL
    
    var body: some View {
        URLImage(url, placeholder: { _ in
            Image(systemName: "image_place_holder")
                .resizable()
                .foregroundColor(Color.gray)
            
            
        },
                 content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                        
        }
        )
    }
    
}

struct FoodRecipesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecipesDetailView(food: FoodModel(name: "Nasi Goreng", desc: "Mantab", image: "https://cintaihidup.com/wp-content/uploads/2017/03/capcay.jpg"))
    }
}
