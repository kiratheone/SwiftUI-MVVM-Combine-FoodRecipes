//
//  AppBarView AppBarView.swift
//  foodrecipes
//
//  Created by Arik on 21/06/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialAppBar
import SwiftUI

struct AppBarView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MDCAppBarNavigationController {
        return MDCAppBarNavigationController()
    }
    
    func updateUIView(_ uiView: MDCAppBarNavigationController, context: Context) {
        
    }
}
