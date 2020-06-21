//
//  FoodsRepository.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//
import Foundation
import Combine

class FoodsRepository{
    private let client : ApiClient
    
    init(client : ApiClient) {
        self.client = client
    }
    
    func getListFoods() -> AnyPublisher<[FoodModel],Error>{
        let resource = Resource(url: URL(string: "http://192.227.240.179:7000/foods")!)
        return client.load(resource)
    }
}
