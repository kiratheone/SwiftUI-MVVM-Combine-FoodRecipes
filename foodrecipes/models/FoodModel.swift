//
//  FoodsModel.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import Foundation

struct FoodModel : Decodable, Identifiable {
    let id: String = UUID().uuidString
    let name : String
    let desc : String
    let image: String
}
