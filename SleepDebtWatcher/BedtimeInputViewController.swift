//
//  BedtimeInputViewController.swift
//  SleepDebtWatcher
//
//  Created by Yohei Kato on 2018/01/07.
//  Copyright © 2018年 Yohei Kato. All rights reserved.
//

import Foundation
import UIKit

class BedtimeInputViewController: UIViewController {
    var currentDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidBedTimeInput(inputDate: Date) -> Bool{
        let calendar = Calendar(identifier: .gregorian)
        print(calendar.component(.year, from: currentDate))
        print(calendar.component(.year, from: inputDate))
        if(calendar.component(.year, from: currentDate) == calendar.component(.year, from: inputDate)){
            return true
        }
        return false
    }
}
