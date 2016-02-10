//
//  ViewController.swift
//  Calculator
//
//  Created by Taylor Schmidt on 2/3/15.
//  Copyright (c) 2015 Taylor Schmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum selection {case DIGIT, OP, EQUAL, AC}
    var valueStack: [Double] = []
    var operatorStack: [String] = []
    var valueStr: String = ""
    var previousSelection = selection.AC
    @IBOutlet weak var display: UILabel!
    
    
    @IBAction func digitSelected(sender: UIButton) {
        
        switch previousSelection {
        case .EQUAL:
            allClearSelected(sender)
        case .DIGIT, .OP, .AC: break // don't do shit yo
        }
        
        valueStr += sender.currentTitle!
        display.text = valueStr
        previousSelection = .DIGIT
    }
    
    
    @IBAction func allClearSelected(sender: UIButton) {
        previousSelection = .AC
        valueStack = []
        operatorStack = []
        display.text = "Math Time Bitch"
        valueStr = ""
    }
    
    @IBAction func operatorSelected(sender: UIButton) {
        
        
        let op: String = sender.currentTitle!
        
        switch previousSelection {
        case .DIGIT:
            // add accruing value to valueStack
            pushValue()
            // if op stack isn't empty and the precedence isn't higher than top of operator stack, then evaluate top operator
            if !operatorStack.isEmpty && !higherPrecedence(op) {
                let eval = evaluateOperator()
                valueStack.insert(eval, atIndex: 0)
                print("Evaled op: \(eval)")
            }
            operatorStack.insert(op, atIndex: 0)
            previousSelection = .OP
        case .OP:
            // replace previous op with new op
            operatorStack.removeAtIndex(0)
            operatorStack.insert(op, atIndex: 0)
            previousSelection = .OP
        case .EQUAL:
            // if op stack isn't empty and the precedence isn't higher than top of operator stack, then evaluate top operator
            if !operatorStack.isEmpty && !higherPrecedence(op) {
                let eval = evaluateOperator()
                valueStack.insert(eval, atIndex: 0)
                print("Evaled op: \(eval)")
            }
            operatorStack.insert(op, atIndex: 0)
            previousSelection = .OP
        case .AC: break  // don't do shit yo
        }
    }
    
    func higherPrecedence(op: String) -> Bool {
        if (op == "×" || op == "÷") && (operatorStack.first! == "+" || operatorStack.first! == "−") {
            print("Op \(op) has higher precedence than \(operatorStack.first!)")
            return true;
        }
        else {
            print("Op \(op) has lower precedence than \(operatorStack.first!)")
            return false;
        }
    }
    
    func pushValue() {
        if valueStr != "" {
            print("Pushed value \(valueStr)")
            valueStack.insert((valueStr as NSString).doubleValue, atIndex: 0)
            display.text = "\(valueStr)"
            valueStr = ""
        }
    }
    
    func evaluateOperator() -> Double {
        let op: String = operatorStack.removeAtIndex(0)
        let val1: Double = valueStack.removeAtIndex(0)
        let val2: Double = valueStack.removeAtIndex(0)
        switch op {
        case "+": return val2 + val1
        case "−": return val2 - val1
        case "×": return val2 * val1
        case "÷": return val2 / val1
        default: assert(false, "\(op) isn't a valid operator")
        }
    }
    
    @IBAction func equalsSelected(sender: UIButton) {
        switch previousSelection {
        case .DIGIT:
            pushValue()
            while !operatorStack.isEmpty { valueStack.insert(evaluateOperator(), atIndex: 0) }
            display.text = "\(valueStack.first!)"
        case .OP:
            // discard previous operation
            operatorStack.removeAtIndex(0)
            while !operatorStack.isEmpty { valueStack.insert(evaluateOperator(), atIndex: 0) }
            display.text = "\(valueStack.first!)"
        case .AC, .EQUAL: break     // don't do shit yo
        }
        
        previousSelection = .EQUAL
    }
}
