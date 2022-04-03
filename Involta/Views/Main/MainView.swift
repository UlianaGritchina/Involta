//
//  ContentView.swift
//  Involta
//
//  Created by Ульяна Гритчина on 01.04.2022.
//

import SwiftUI

struct MainView: View {
    @Namespace var topID2
    @Namespace var bottomI2
    @StateObject var vm = MainViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                switch vm.downloadStatus {
                    
                case .badInternetContection:
                    TryAgainView(title: "Check your internet conaction and",
                                 action: {vm.getMassages(offset: 0)})
                    
                case .noData:
                    TryAgainView(title: "No messages",
                                 action: {vm.getMassages(offset: 0)})
                    
                case .downloading: ProgressView()
                    
                default: messagesScrollView
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Involta")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}

extension MainView {
    private var messagesScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView {
                HStack {
                    Spacer()
                    Button("more") { vm.getMoreMessages() }
                }.padding()
                
                VStack(alignment: .leading) {
                    ForEach(0..<vm.allMessages.count, id: \.self) { index in
                        MessageView(message: vm.allMessages[index])
                            .id(index)
                    }
                }
                .padding()
                .onAppear(perform: {
                    proxy.scrollTo(bottomI2)
                })
                
                HStack{Spacer()}.id(bottomI2)
            }
        }.onAppear {
            vm.allMessages = vm.messages.reversed()
        }
    }
}
