//
//  CalculateBrain.swift
//  Calculator
//
//  Created by liguiyan on 2017/5/23.
//  Copyright © 2017年 partrick. All rights reserved.
//

import Foundation

struct CalculateBrain {
    
    private var accumulator: Double?
    
    mutating func set(operand: Double) {
        accumulator = operand
    }
    
    private enum Operation {
        case constant(Double)
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equal
    }
    
    private let operations: [String: Operation] = [
        "e": .constant(M_E),
        "π": .constant(Double.pi),
        "±": .unary({ -$0 }),
        "√": .unary({ sqrt($0) }),
        "+": .binary(+),
        "-": .binary(-),
        "×": .binary({ $0 * $1 }),
        "÷": .binary({ $0 / $1 }),
        "=": .equal
    ]
    
    private struct PendingBinaryOperation {
        
        let firstOperand: Double
        let operation: (Double, Double) -> Double
        
        func perform(with secondOperand: Double) -> Double {
            return operation(firstOperand, secondOperand)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private mutating func performPendingBinaryOperation() {
        
        if pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func perform(operation: String) {
        guard let selectedOperation = operations[operation] else {
            print("no such \(operation) operation in operations dictionary")
            return
        }
        switch selectedOperation {
        case .constant(let value):
            accumulator = value
        case .unary(let unaryOperaiton):
            accumulator = unaryOperaiton(accumulator!)
        case .binary(let binaryOperation):
            performPendingBinaryOperation()
            pendingBinaryOperation = PendingBinaryOperation(firstOperand: accumulator!, operation: binaryOperation)
        case .equal:
            performPendingBinaryOperation()
        }
    }
    
    var result: Double? {
        
        get {
            return accumulator
        }
    }
}
