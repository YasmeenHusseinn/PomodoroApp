//
//  SearchViewController.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/19/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var typeWord: UITextField!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var definitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let apiKey = "8771330d-4ad4-4216-bbc1-54575f7daa44"
    let baseURL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let word = typeWord.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !word.isEmpty else {
            return
    }

        wordLabel.text = word.capitalized
        
        fetchDefinition(for: word)
    }
    
    func fetchDefinition(for word: String) {
        let urlString = "\(baseURL)\(word)?key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                
                if let definition = json?.first?["shortdef"] as? [String], !definition.isEmpty {
                    DispatchQueue.main.async {
                        self.definitionLabel.text = definition.joined(separator: "\n")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.definitionLabel.text = "Definition not found"
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

}
