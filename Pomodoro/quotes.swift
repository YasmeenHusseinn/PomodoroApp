//
//  quotes.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/29/24.
//

//import Foundation
//
//import UIKit
//
//class QuoteViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        fetchInspirationalQuote()
//    }
//    
////    func fetchInspirationalQuote() {
////        let category = "inspirational"
////        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(category)") else {
////            print("Invalid URL")
////            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error:", error)
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let quotes = try JSONDecoder().decode([Quote].self, from: data)
//                if let quote = quotes.first {
//                    DispatchQueue.main.async {
//                        self.quotes.text = quote.quote
//                    }
//                } else {
//                    print("No quotes found")
//                }
//            } catch {
//                print("Error decoding JSON:", error)
//            }
//        }.resume()
//    }
//}
//
//struct Quote: Codable {
//    let quote: String
//}

