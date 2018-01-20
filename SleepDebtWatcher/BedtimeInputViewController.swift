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
    
    @IBOutlet weak var testtest4: UILabel!
    
    var timeOfSleep: DateComponents!
    var wakeTime: DateComponents!
    var bedtime_hour: Int! = 0
    var bedtime_minute: Int! = 0
    var sleepDebt_hour: Int! = 0
    var sleepDebt_minute: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timeSlot.text = "就寝時間"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTimeOfSleep(rv_timeOfSleep: DateComponents){
        timeOfSleep = rv_timeOfSleep
    }
    
    func setWakeTime(rv_wakeTime: DateComponents){
        wakeTime = rv_wakeTime
    }
    
    func isValidBedtime() -> Bool{
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: timeOfSleep)!
        let dateTo = calendar.date(from: wakeTime)!
        let comps = calendar.dateComponents([.second], from: dateFrom, to: dateTo)
        return (comps.second! > 0)
    }
    
    func calcBedtime(){
        if(isValidBedtime()){
            let calendar = Calendar.current
            let dateFrom = calendar.date(from: timeOfSleep)!
            let dateTo = calendar.date(from: wakeTime)!
            let comps = calendar.dateComponents([.hour, .minute], from: dateFrom, to: dateTo)
            bedtime_hour = comps.hour
            bedtime_minute = comps.minute
        }
        else{
            bedtime_hour = 0
            bedtime_minute = 0
        }
    }
    
    func calcSleepDebt(){
        calcBedtime()
        let sleepTimeThreshold = 8
        if((bedtime_hour > 0) && (bedtime_hour < sleepTimeThreshold)){
                sleepDebt_hour = sleepDebt_hour + (sleepTimeThreshold - bedtime_hour)
        }
        else if((bedtime_hour >= sleepTimeThreshold) && (sleepDebt_hour >= 0)){
            sleepDebt_hour = sleepDebt_hour - (bedtime_hour - sleepTimeThreshold)
            if(sleepDebt_hour < 0){
                sleepDebt_hour = 0
            }
        }
        else {
            //Do Nothing
        }
    }
}
