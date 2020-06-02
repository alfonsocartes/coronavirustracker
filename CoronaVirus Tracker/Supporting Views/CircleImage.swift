//
//  CircleImage.swift
//  Overview
//
//  Created by Alfonso Cartes on 28/06/2019.
//  Copyright © 2019 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct CircleImage : View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(minWidth: 250, maxWidth: 250, minHeight: 250, maxHeight: 250)
            .background(Color(.systemBackground))
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color(.systemBackground), lineWidth: 4))
            .shadow(radius: 10)
    }
}

#if DEBUG
struct CircleImage_Previews : PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("0"))
    }
}
#endif
