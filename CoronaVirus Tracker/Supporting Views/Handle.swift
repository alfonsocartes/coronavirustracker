//
//  Handle.swift
//  CoronaVirus Tracker
//
//  Created by Alfonso Cartes on 31/01/2020.
//  Copyright © 2020 Alfonso Cartes. All rights reserved.
//

import SwiftUI

struct Handle: View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: handleThickness / 2.0)
                .frame(width: 40, height: handleThickness)
                .foregroundColor(Color.secondary)
        }
    }
}

struct Handle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Handle()
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
