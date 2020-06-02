//
//  ImagePopUpView.swift
//  Overview
//
//  Created by Alfonso Cartes on 23/12/2019.
//  Copyright © 2019 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct ImagePopUpView: View {
    
    //var landmark: Landmark
    
    var image: Image
    var imageCredits: String
    var imageURL: String
    
    @State var scale: CGFloat = 1.0
    @State var lastScale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            image
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(MagnificationGesture()
                    .onChanged { value in
                        let delta = value / self.lastScale
                        self.lastScale = value
                        let newScale = self.scale * delta
                        self.scale = newScale
                        print("Scale \(Double(self.scale))")
                    }
                    .onEnded { _ in
                        self.lastScale = 1.0
                    }
                )
            Spacer()
            Text("\(imageCredits)")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding()
                .onTapGesture {
                    if let url = URL(string: self.imageURL) {
                        UIApplication.shared.open(url)
                    }
                }
        }
    }
}

struct ImagePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePopUpView(image: Image("3D_coronavirus"),
                       imageCredits: "By https://www.scientificanimations.com - https://www.scientificanimations.com/wiki-images/ , https://phil.cdc.gov/Details.aspx (its the originating source), CC BY-SA 4.0",
                       imageURL: "https://commons.wikimedia.org/w/index.php?curid=86436446")
    }
}
