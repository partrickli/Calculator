//
//  ViewController.swift
//  Calculator
//
//  Created by liguiyan on 2017/5/21.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brain = CalculateBrain()
    
    // track value of display label
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var userIsInTheMiddleOfTyping = false
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        if let digit = sender.currentTitle, let displayText = display.text {
            if userIsInTheMiddleOfTyping {
                display.text = displayText + digit
            } else {
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        brain.set(operand: displayValue)
        if let mathematicalSymbol = sender.currentTitle {
            brain.perform(operation: mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
}


