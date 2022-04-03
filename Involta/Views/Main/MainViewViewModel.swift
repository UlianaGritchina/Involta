//
//  DownloadViewModel.swift
//  Involta
//
//  Created by Ульяна Гритчина on 01.04.2022.
//

import Foundation

enum DownloadStatus {
    case downloading
    case badInternetContection
    case noData
    case ok
}

class MainViewViewModel: ObservableObject {
    
    init () {
        getMassages(offset: 0)
        allMessages = messages
    }
    
    @Published var downloadStatus: DownloadStatus = .downloading
    @Published var messages: [String] = []
    @Published var allMessages: [String] = []
    var oldMessages: [String] = []
    var count = 0
    
    
    func getMoreMessages() {
        oldMessages = allMessages
        count += 20
        getMassages(offset: count)
        allMessages.removeAll()
        allMessages += messages.reversed()
        allMessages += oldMessages
    }
    
     func getMassages(offset: Int) {
         guard let url = URL(string: "https://numero-logy-app.org.in/getMessages?offset=\(offset)")
         else { return }
         
         downloadData(url: url) { returnedData in
             if let data = returnedData {
                 guard let newResult = try? JSONDecoder().decode(Result.self, from: data) else {
                     DispatchQueue.main.async { [weak self] in
                         self?.downloadStatus = .noData
                     }
                     return
                 }
                 
                 DispatchQueue.main.async { [weak self] in
                     self?.messages = newResult.result ?? []
                     self?.downloadStatus = .ok
                 }
             } else {
                 self.downloadStatus = .badInternetContection
             }
         }
     }
    
    private func downloadData(url: URL, complitionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                      complitionHandler(nil)
                      return
                  }
            
            complitionHandler(data)
            
        }.resume()
    }
    
}
