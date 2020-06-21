//
//  AppDelegate+Inject.swift
//  foodrecipes
//
//  Created by Arik on 19/06/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerMyApi()
        registerMyRepository()
        registerMyViewModel()
    }
}

extension Resolver {
    
    public static func registerMyApi() {
        register{ApiClient()}
    }
    
    public static func registerMyRepository() {
        register{FoodsRepository(client: resolve())}
    }
    
    public static func registerMyViewModel() {
        register{FoodsViewModel(rep: resolve())}
    }
    
}
