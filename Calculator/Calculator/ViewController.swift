//
//  ViewController.swift
//  Calculator
//
//  Created by Taylor Schmidt on 2/3/15.
//  Copyright (c) 2015 Taylor Schmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operatorStack: [String] = []
    var postfixArr: [String] = []
    var expectingOperator = false
    var newExpression = true
    @IBOutlet weak var display: UILabel!
    
    
    @IBAction func digitSelected(sender: UIButton) {
        if newExpression {
            newExpression = false
            display.text = sender.currentTitle!
        } else {
            display.text! += sender.currentTitle!
        }
        expectingOperator = true
    }
    
    
    @IBAction func allClearSelected(sender: UIButton) {
        display.text = "Enter an expression"
        postfixArr = []
        expectingOperator = false
        newExpression = true
    }
    
    @IBAction func operatorSelected(sender: UIButton) {
        if expectingOperator {
            expectingOperator = false
            display.text! += " \(sender.currentTitle!) "
        }
    }
    
    @IBAction func equalsSelected(sender: UIButton) {
        createPostFixExpr(display.text!)
        display.text = "\(evaluatePostFixExpression())"
        newExpression = true
        
    }
    
    func createPostFixExpr(expr: String) {
        var exprArr = split(expr) { $0 == " " }
        for str in exprArr {
            switch str {
            case "+", "−":
                while operatorStack.count != 0  {
                    postfixArr.append(operatorStack.removeLast())
                }
                operatorStack.append(str)
                println(operatorStack)
            case "×", "÷":
                while operatorStack.count != 0 && (operatorStack.last! == "×" || operatorStack.last! == "÷") {
                    postfixArr.append(operatorStack.removeLast())
                }
                operatorStack.append(str)
            default: // if it's a number
                postfixArr.append(str)
            }
        }
        while operatorStack.count != 0 { postfixArr.append(operatorStack.removeLast()) }
        println(postfixArr)
    }

    func evaluatePostFixExpression() -> Double {
        var valStack: [Double] = []
        postfixArr = postfixArr.reverse()
        while (postfixArr.count != 0) {
            println(valStack)
            if postfixArr.last == "×" || postfixArr.last == "÷" || postfixArr.last == "−" || postfixArr.last == "+" {
                let op1 = (valStack.removeLast())
                let op2 = (valStack.removeLast())
                if postfixArr.last == "×" {valStack.append(op1 * op2)}
                else if postfixArr.last == "÷" {valStack.append(op2 / op1)}
                else if postfixArr.last == "−" {valStack.append(op2 - op1)}
                else if postfixArr.last == "+" {valStack.append(op1 + op2)}
                else {println("ERROR!!!")}
                postfixArr.removeLast()
            } else {
                valStack.append((postfixArr.removeLast() as NSString).doubleValue)
            }
        }
        if valStack.count != 1 { println("ERROR!!!!") }
        return valStack.last!
    }
}
