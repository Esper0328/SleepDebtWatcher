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
    

    @IBOutlet weak var timeSlot: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    var changeddate : DateComponents!
    @IBAction func changeDate(_ sender: Any) {
        changeddate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: (sender as AnyObject).date)
    }
    
    enum SleepInputMode{
        case TimeOfSleep
        case WakeTime
    }
    
    var timeOfSleep: DateComponents!
    var wakeTime: DateComponents!
    var bedtime: Double! = 0.0       //unit:[H]
    var sleepDebt: Double! = 0.0     //unit:[H]
    var sleepInputState: SleepInputMode = .TimeOfSleep
    var weekdayOfCalcBedtime : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeSlot.text = "就寝時間"
        let userDefaults = UserDefaults.standard
        sleepDebt = userDefaults.double(forKey: "sleepDebt")
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
    
    @IBAction func setBedtimeEvent(_ sender: Any) {
        switch sleepInputState {
        case .TimeOfSleep:
            timeOfSleep = changeddate
            sleepInputState = .WakeTime
            timeSlot.text = "起床時間"
        case .WakeTime:
            wakeTime = changeddate
            calcSleepDebt()
            performSegue(withIdentifier: "sleepDebtFromInput", sender: nil)
        }
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
            bedtime = Double(comps.hour!) + Double(comps.minute!)/60.0
            weekdayOfCalcBedtime = calendar.component(.weekday, from: dateTo)
        }
        else{
            bedtime = 0.0
            weekdayOfCalcBedtime = 0
        }
    }
    
    func calcSleepDebt(){
        calcBedtime()
        let sleepTimeThreshold = 8.0
        if((bedtime > 0) && (bedtime < sleepTimeThreshold)){
            sleepDebt = sleepDebt + (sleepTimeThreshold - bedtime)
        }
        else if((bedtime >= sleepTimeThreshold) && (sleepDebt >= 0)){
            sleepDebt = sleepDebt - (bedtime - sleepTimeThreshold)
            if(sleepDebt < 0){
                sleepDebt = 0
            }
        }
        else {
            //Do Nothing
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "sleepDebtFromInput"){
            let viewController: SleepDebtHistoryViewController = (segue.destination as? SleepDebtHistoryViewController)!
            viewController.sleepDebtValue = sleepDebt
            let weekdayFromZero = weekdayOfCalcBedtime % 7
            viewController.setSleepDebt(weekday: weekdayFromZero , rv_sleepDebt: sleepDebt)//from 1-7(from Apple spec of Weekday) to 0-6(for array index)
            let userDefaults = UserDefaults.standard
            userDefaults.set(sleepDebt, forKey: "sleepDebt")
            for i in 0..<7 {
                if(i == weekdayFromZero){
                    userDefaults.set(sleepDebt, forKey: "sleepDebt" + String(weekdayFromZero))
                }
            }
        }
    }
}
