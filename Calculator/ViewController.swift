//
//  ViewController.swift
//  Calculator
//
//  Created by liguiyan on 2017/5/21.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            print("\(digit) was pressed")
        }
    }
}

