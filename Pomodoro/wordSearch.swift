//
//  wordSearch.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/29/24.
//

import Foundation

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var definitionLabel: UILabel!
    
    let apiKey = "YOUR_API_KEY"
    let baseURL = "https://api.dictionary.com/api/v3/references/learners/json/"
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let word = wordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !word.isEmpty else {
            assertionFailure("Invalid response")
            return
        }
        
        fetchDefinition(for: word)
    }
    
    func fetchDefinition(for word: String) {
        let urlString = "\(baseURL)\(word)?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid response")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                // Handle network error
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                
                if let definition = json?.first?["definition"] as? String {
                    DispatchQueue.main.async {
                        self.definitionLabel.text = definition
                    }
                } else {
                    // Handle word not found
                    DispatchQueue.main.async {
                        self.definitionLabel.text = "Definition not found"
                    }
                }
            } catch {
                // Handle JSON parsing error
            }
        }
        
        task.resume()
    }
}

