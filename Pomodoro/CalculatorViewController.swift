//
//  CalculatorViewController.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/19/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var math: String = ""
    
    
    @IBOutlet weak var calculatorResults: UILabel!
    
    @IBOutlet weak var calculatorMath: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        math = ""
        calculatorMath.text = ""
        calculatorResults.text = ""
    }

    @IBAction func decimalButton(_ sender: Any) {
        addMath(value: ".")
    }
    
    @IBAction func backButton(_ sender: Any) {
        if(!math.isEmpty)
        {
            math.removeLast()
            calculatorMath.text = math
        }
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        math = ""
        calculatorMath.text = ""
        calculatorResults.text = ""
    }
    
    @IBAction func plusMinusButton(_ sender: Any) {
        if math.isEmpty {
            math += "-"
        } else {
            if math.first == "-" {
                math.removeFirst()
            } else {
                math = "-" + math
            }
        }
        calculatorMath.text = math
    }
    
    @IBAction func percentButton(_ sender: Any) {
        addMath(value: "%")
    }
    
    @IBAction func divisionButton(_ sender: Any) {
        addMath(value: "/")
    }
    
    @IBAction func multiplyButton(_ sender: Any) {
        addMath(value: "*")
    }
    
    
    @IBAction func minusButton(_ sender: Any) {
        addMath(value: "-")
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        addMath(value: "+")
    }
    
    @IBAction func equalButton(_ sender: Any) {
        if (valid())
        {
            let percent = math.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: percent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
        }
        else
        {
            let alert = UIAlertController(
                title: "Invalid Input", message: "Can't compute input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func valid() -> Bool
    {
        var count = 0
        var charIndexes = [Int]()
        
        for char in math
        {
            if (specialCharacter(char: char)){
                charIndexes.append(count)
            }
            count += 1
        }
        
        var prev: Int = -1
        
        for index in charIndexes
        {
            if (index == 0)
            {
                return false
            }
            
            if (index == math.count - 1)
            {
                return false
            }
            
            if (prev != -1)
            {
                if (index - prev == 1)
                {
                    return false
                }
            }
            prev = index
        }
        return true
    }
    
    func specialCharacter (char: Character) -> Bool
    {
        if(char == "*")
        {
            return true
        }
        if(char == "/")
        {
            return true
        }
        if(char == "+")
        {
            return true
        }
        return false
    }


    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.2f", result)
        }
    }

    
    @IBAction func nineButton(_ sender: Any) {
        addMath(value: "9")
    }
    
    @IBAction func eightButton(_ sender: Any) {
        addMath(value: "8")
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        addMath(value: "7")
    }
    
    @IBAction func sixButton(_ sender: Any) {
        addMath(value: "6")
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        addMath(value: "5")
    }
    
    @IBAction func fourButton(_ sender: Any) {
        addMath(value: "4")
    }
    
    @IBAction func threeButton(_ sender: Any) {
        addMath(value: "3")
    }
    
    @IBAction func twoButton(_ sender: Any) {
        addMath(value: "2")
    }
    
    @IBAction func oneButton(_ sender: Any) {
        addMath(value: "1")
    }
    
    func addMath(value: String){
        math += value
        calculatorMath.text = math
    }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


