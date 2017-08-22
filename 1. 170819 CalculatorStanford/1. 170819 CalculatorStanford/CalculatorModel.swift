//
//  CalculatorModel.swift
//  1. 170819 CalculatorStanford
//
//  Created by Kim Rants on 20/08/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//


// This is the CalculatorBrain / Model of our app
// Never(!) import UIKit for your model --> Model is UI independent!
import Foundation

// create class -> does not inherit from anything. Just a "base class"
class CalculatorModel {
    
    private var accumulator = 0.0
    private var floatTracker = false
    private var appendDot = false
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    // Create table with opeartions --> Use dictionaries, which is a table of pairs
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi), ///Double.pi,
        "e": Operation.Constant(M_E), //M_E
        // See below --> it is a closure!
        "±": Operation.UnaryOperation({ -$0 }),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        // Use closures to sort of "make functions" inside the function call --> closure
        // But if you use $0, $1, etc., which i standard for closures, you don't need to write them as arguments...
        // So it simplifies to the below, i.e. closures are really poweful in Swift!
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "-": Operation.BinaryOperation({$0 - $1}),
        "=": Operation.Equals,
        ".": Operation.Float
    ]
    
    // Double inside (   )  is an "associated" value with the Enum... like as for Optionals
    private enum Operation {
        case Constant(Double)
        // For UnaryOperations the associated value is a function that takes a Double and returns a Double
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case Float
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue):
                accumulator = associatedConstantValue
            case .UnaryOperation(let associatedFunction):
                accumulator = associatedFunction(accumulator)
            case .BinaryOperation(let associatedFunction):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: associatedFunction, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            case .Float:
               executeFloatOperation()
            }
        }
    }
    
    private func executeFloatOperation() {
        if accumulator == floor(accumulator) && !floatTracker {
            appendDot,  = true
            floatTracker = true
        } else {
            accumulator = 0
            appendDot, floatTracker = true
            Boya Tester
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    // Create var of type Optional struct
    private var pending: PendingBinaryOperationInfo?
    
    // Notice that a data type is Capitalized!
    private struct PendingBinaryOperationInfo {
        // Notice that I give the binaryFunction a type that takes two doubles and returns a double
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    // a read-only property
    var result: Double {
        get {
            return accumulator
        }
    }
}
