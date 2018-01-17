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
    var timeOfSleep: DateComponents!
    var wakeTime: DateComponents!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTimeOfSleep(_timeOfSleep: DateComponents){
        timeOfSleep = _timeOfSleep
    }
    
    func setWakeTime(_wakeTime: DateComponents){
        wakeTime = _wakeTime
    }
    
    func isValidBedtime() -> Bool{
        return true
    }
}
