//
//  ContentView.swift
//  foodrecipes
//
//  Created by Arik on 17/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import SwiftUI
import URLImage
import Resolver

struct FoodRecipesListView: View {
    
    @ObservedObject private var viewModel : FoodsViewModel = Resolver.resolve()
    
    var body: some View {
        NavigationView{
            content.onAppear{
                self.viewModel.send(event: .onAppear)
            }
            
        }
    }
    
    private var content: some View {
        
        switch viewModel.state {
        case .idle:
            return Text("sabar gaes").eraseToAnyView()
        case .loading:
            return spinner.eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let foods):
            return ListView(listFood: foods).eraseToAnyView()
        }
    }
    
    
}

private var spinner: Spinner { Spinner(isAnimating: true, style: .large) }

struct ListView: View{
    let listFood : [FoodModel]
    var body: some View {
        List(listFood) { food in
            NavigationLink(destination: FoodRecipesDetailView(food: food)){
                ItemView(model: food)
            }.navigationBarTitle("Food Recipes")
        }
        .navigationBarItems(trailing: NavigationLink(destination: AboutView()) {
            Text("About")
        }.buttonStyle(PlainButtonStyle()))
    }
}

struct ItemView: View {
    let model : FoodModel
    var body: some View {
        HStack {
            ItemImageVIew(url: model.image)
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.headline)
                Text(model.desc)
                    .font(.subheadline)
                    .lineLimit(2)
                    .foregroundColor(Color.gray)
                
                
            }
        }.padding(.top,8).padding(.bottom)
    }
    
}

struct ItemImageVIew : View{
    let url : String
    
    var body: some View {
        URLImage(URL(string: url)!, placeholder: { _ in
            Circle()
                .overlay(
                    Circle()
            ).foregroundColor(Color.gray)
                .frame(width: 80, height: 80)
            
        },
                 content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
        }
        )
    }
    
}


