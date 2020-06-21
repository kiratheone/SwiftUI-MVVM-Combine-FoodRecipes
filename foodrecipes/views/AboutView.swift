//
//  AboutView.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import SwiftUI
import URLImage

struct AboutView: View {
    
    var body: some View {
        VStack(spacing: 10) {
            ProfileImageVIew()
                .padding(.top, 20)
            Text("Arik Achmad")
            Text("arikarik.ae@gmail.com")
                .navigationBarTitle("About")
            Spacer()
        }
    }
}

struct ProfileImageVIew : View{
    let url :URL = URL(string: "https://d17ivq9b7rppb3.cloudfront.net/small/avatar/201605020833561bb6afa2845a8eec113834df98ca6876.jpg")!
    
    var body: some View {
        URLImage(url, placeholder: { _ in
            Image(systemName: "circle")
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
        },
                 content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
        }
        )
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
