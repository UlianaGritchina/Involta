//
//  MassageView.swift
//  Involta
//
//  Created by Ульяна Гритчина on 03.04.2022.
//

import SwiftUI

struct MessageView: View {
    let message: String
    var body: some View {
        Text(message)
            .padding()
            .background(
                LinearGradient(colors: [.blue.opacity(0.4), .blue.opacity(0.3)],
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .cornerRadius(20)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Message")
    }
}
