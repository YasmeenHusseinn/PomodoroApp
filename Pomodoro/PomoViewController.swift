//
//  PomoViewController.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/17/24.
//

import UIKit

class PomoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quotes: UILabel!
    
    @IBOutlet weak var taskButton: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var timerLabel: UITextField!
    
    @IBOutlet weak var backgroundimage: UIImageView!
    
    var timer: Timer = Timer()
    var count: Int = 25 * 60
    var isCounting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quotes.backgroundColor = UIColor.clear
        fetchInspirationalQuote()
        
    }

    @IBAction func playTapped(_ sender: Any) {
        isCounting.toggle()
        if isCounting {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let word = taskButton.text,
              !word.isEmpty else {
            return
        }
        taskButton.text = word.capitalized
        taskButton.backgroundColor = UIColor.systemYellow
        taskButton.tintColor = UIColor.green
    }
    
    
    
    
    @IBAction func pauseTapped(_ sender: Any) {
        stopTimer()
        isCounting = false
        
    }
    
    
    @IBAction func resetTapped(_ sender: Any) {
        stopTimer()
        count = 25 * 60
        backgroundimage.image = UIImage(named: "background")
        isCounting = false
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
        let minutes = count / 60
        let seconds = count % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc func updateTimer() {
        if count > 0 {
            count -= 1
            DispatchQueue.main.async { // Update UI on the main thread
                self.timerLabel.text = self.formatTime(self.count)
            }
        } else {
            stopTimer()
            isCounting = false
            backgroundimage.image = UIImage(named: "background2")
            count = 5
            startTimer()
            if count < 0{
                stopTimer()
                count = 25 * 60
                startTimer()
            }
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func fetchInspirationalQuote() {
        let category = "inspirational"
        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(category)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("hzsy8Lky6NgbFabVe4vcvg==qySITL3iqoQKs9N9", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                if let quote = quotes.first {
                    DispatchQueue.main.async {
                        self.quotes.text = quote.quote
                    }
                } else {
                    print("No quotes found")
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }.resume()
    }
    
    func startTimerToUpdateQuotes() {
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateQuotes), userInfo: nil, repeats: true)
    }
    
    @objc func updateQuotes() {
        fetchInspirationalQuote()
    }
}

struct Quote: Codable {
    let quote: String
    let author: String
}
