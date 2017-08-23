//
//  ViewController.swift
//  1. 170819 CalculatorStanford
//
//  Created by Kim Rants on 19/08/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    
    
    // IBAction from View to our Controller
    @IBAction private func touchDigit(_ sender: UIButton) {
        // Take the sender (UIButton) and take its title
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    // Create computed property --> helps with type casting
    // displayValue  is a double
    private var displayValue: Double {
        // gets the display text and casts it to a Double
        get {
            return Double(display.text!)!
        }
        // Sets the display as a String --> newValue is a keyword, is a Double that someone can set in the code (e.g. via an operation)
        set {
            display.text = String(newValue)
        }
    }
    
    // Create variable of type CalculatorModel (OBS!)
    private var brain: CalculatorModel = CalculatorModel()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        // set the display value equal to "result" / accumulator
        displayValue = brain.result
        
    }
  
}

