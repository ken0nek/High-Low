//
//  ViewController.swift
//  High-Low
//
//  Created by Ken Tominaga on 2/3/15.
//  Copyright (c) 2015 Ken Tominaga. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var turnLabel: UILabel!
    @IBOutlet private weak var inputField: UITextField!
    
    private let max = 100
    private var targetNumber = 0
    private var turn = 0
    private var continueGuessing = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputField.delegate = self
        
        initialize()
    }

    @IBAction func startGame() {
        initialize()
    }
    
    private func initialize() {
        continueGuessing = true
        messageLabel.text = ""
        inputField.placeholder = "Enter a number between 0 and \(max)."
        inputField.text = ""
        turn = 0
        turnLabel.text = "\(turn) times"
        targetNumber = Int(arc4random_uniform(UInt32(max + 1)))
        print("The number to guess is: \(targetNumber)") // for debug
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let inputNumber = Int(text) , inputNumber >= 0 && inputNumber <= max else {
            messageLabel.text = "Invalid"
            return
        }
        
        if inputNumber < targetNumber {
            messageLabel.text = "Higher!"
        } else if inputNumber > targetNumber {
            messageLabel.text = "Lower!"
        } else {
            messageLabel.text = "Correct!"
            continueGuessing = false
        }
        
        turn += 1
        turnLabel.text = "\(turn) times"
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return continueGuessing
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
