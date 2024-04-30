//
//  tiktactoeViewController.swift
//  Pomodoro
//
//  Created by Yasmeen Hussein on 4/25/24.
//

import UIKit

class tiktactoeViewController: UIViewController {
    enum Turn {
        case X
        case O
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var A1: UIButton!
    
    @IBOutlet weak var A2: UIButton!
    
    @IBOutlet weak var A3: UIButton!
    
    @IBOutlet weak var B1: UIButton!
    
    @IBOutlet weak var B2: UIButton!
    
    @IBOutlet weak var B3: UIButton!
    
    @IBOutlet weak var C1: UIButton!
    
    @IBOutlet weak var C2: UIButton!
    
    @IBOutlet weak var C3: UIButton!
    
    var first = Turn.X
    var current = Turn.O
    
    var nought = "O"
    var cross = "X"
    var board = [UIButton]()
    
    var Xscore = 0
    var Oscore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()

        // Do any additional setup after loading the view.
    }
    
    func initBoard()
        {
            board.append(A1)
            board.append(A2)
            board.append(A3)
            board.append(B1)
            board.append(B2)
            board.append(B3)
            board.append(C1)
            board.append(C2)
            board.append(C3)
        }
    
    @IBAction func allButtons(_ sender: UIButton) {
        addToBoard(sender )
                
        if checkForVictory(cross)
        {
            Xscore += 1
            resultAlert(title: "X Wins!")
            initBoard()
        }
        
        if checkForVictory(nought)
        {
            Oscore += 1
            resultAlert(title: "0 Wins!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s :String) -> Bool
        {
            // Horizontal Win
            if symbol(A1, s) && symbol(A2, s) && symbol(A3, s)
            {
                return true
            }
            if symbol(B1, s) && symbol(B2, s) && symbol(B3, s)
            {
                return true
            }
            if symbol(C1, s) && symbol(C2, s) && symbol(C3, s)
            {
                return true
            }
            
            // Vertical Win
            if symbol(A1, s) && symbol(B1, s) && symbol(C1, s)
            {
                return true
            }
            if symbol(A2, s) && symbol(B2, s) && symbol(C2, s)
            {
                return true
            }
            if symbol(A3, s) && symbol(B3, s) && symbol(C3, s)
            {
                return true
            }
            
            // Diagonal Win
            if symbol(A1, s) && symbol(B2, s) && symbol(C3, s)
            {
                return true
            }
            if symbol(A3, s) && symbol(B2, s) && symbol(C1, s)
            {
                return true
            }
            
            return false
        }
        



    func symbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let message = "\nO " + String(Oscore) + "\n\nX " + String(Xscore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }

    
    func resetBoard()
        {
            for button in board
            {
                button.setTitle("", for: .normal)
                button.isEnabled = true
            }
            if first == Turn.O
            {
                first = Turn.X
                turnLabel.text = cross
            }
            else if first == Turn.X
            {
                first = Turn.O
                turnLabel.text = nought
            }
            current = first
        }
        
        func fullBoard() -> Bool
        {
            for button in board
            {
                if button.title(for: .normal) == nil || button.title(for: .normal) == ""
                {
                    return false
                }
            }
            return true
        }
        
        func addToBoard(_ sender: UIButton)
        {
            if(sender.title(for: .normal) == nil || sender.title(for: .normal) == "")

            {
                if(current == Turn.O)
                {
                    sender.setTitle(nought, for: .normal)
                    current = Turn.X
                    turnLabel.text = cross
                }
                else if(current == Turn.X)
                {
                    sender.setTitle(cross, for: .normal)
                    current = Turn.O
                    turnLabel.text = nought
                }
                            sender.isEnabled = false
                        }
                    }
                    
                }
