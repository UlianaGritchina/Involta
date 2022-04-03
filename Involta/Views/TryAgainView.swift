//
//  TryAgainView.swift
//  Involta
//
//  Created by Ульяна Гритчина on 03.04.2022.
//

import SwiftUI

struct TryAgainView: View {
    let title: String
    let action: () -> Void
    var body: some View {
        VStack {
            Text(title).padding()
            Button("Try again") { action() }
        }
    }
}

struct TryAgainView_Previews: PreviewProvider {
    static var previews: some View {
        TryAgainView(title: "error", action: {})
    }
}
