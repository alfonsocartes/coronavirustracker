//
//  ViewNotAvailable.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 01/02/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct ViewNotAvailable<Content>: View where Content: View {
    
    //@Binding var isShowing: Bool
    var isShowing: Bool
    var viewName: String
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                VStack {
                    Text("\(self.viewName) not available.")
                        .font(.headline)
                    Text("Please try again later.")
                        .font(.subheadline)
                    //ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }
}

struct ViewNotAvailable_Previews: PreviewProvider {
    static var previews: some View {
        ViewNotAvailable(isShowing: true, viewName: "View") {
            NavigationView {
               List(["1", "2", "3", "4", "5"], id: \.self) { row in
                   Text(row)
               }.navigationBarTitle(Text("A List"), displayMode: .large)
           }
        }
    }
}
