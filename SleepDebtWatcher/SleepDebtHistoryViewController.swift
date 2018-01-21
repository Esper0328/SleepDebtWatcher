//
//  SleepDebtHistoryViewController.swift
//  SleepDebtWatcher
//
//  Created by Yohei Kato on 2018/01/07.
//  Copyright © 2018年 Yohei Kato. All rights reserved.
//

import Foundation
import UIKit


class SleepDebtHistoryViewController: UIViewController {

    
    @IBOutlet weak var sleepDebtValueLabel: UILabel!
    var sleepDebtValue: Int! = 0
    var weekdayOfCalcBedtime:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepDebtValueLabel.text = String(sleepDebtValue)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
