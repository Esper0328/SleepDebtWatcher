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
    var bedtime_hour: Int!
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
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: timeOfSleep)!
        let dateTo = calendar.date(from: wakeTime)!
        let comps = calendar.dateComponents([.second], from: dateFrom, to: dateTo)
        return (comps.second! > 0)
    }
    
    func calcBedtime(){
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: timeOfSleep)!
        let dateTo = calendar.date(from: wakeTime)!
        let comps = calendar.dateComponents([.hour, .minute], from: dateFrom, to: dateTo)
        bedtime_hour = comps.hour
    }
}
