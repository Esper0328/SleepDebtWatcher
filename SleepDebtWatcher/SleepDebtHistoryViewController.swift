//
//  SleepDebtHistoryViewController.swift
//  SleepDebtWatcher
//
//  Created by Yohei Kato on 2018/01/07.
//  Copyright © 2018年 Yohei Kato. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepDebtHistoryViewController: UIViewController {

    
    @IBOutlet weak var sleepDebtValueLabel: UILabel!
    var sleepDebtValue:Double = 0
    var sleepDebt:[Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    let highLimitTime = 4.0
    let midLimitTime = 2.0

    @IBOutlet weak var barDebtChartView: BarChartView!

    @IBAction func resetSleepDebtEvent(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(0.0, forKey: "sleepDebt")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepDebtValueLabel.text = String(sleepDebtValue)
        setChart(y: sleepDebt)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSleepDebt(weekday: Int, rv_sleepDebt: Double){
        sleepDebt[weekday] = rv_sleepDebt
    }
    
    //Merged
    func setChart(y: [Double]) {
        // y軸
        var dataEntries = [BarChartDataEntry]()
        
        for (i, val) in y.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(i), y: val)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "負債")
        let xaxis = XAxis()
        xaxis.valueFormatter = BarChartFormatter()
        barDebtChartView.xAxis.labelCount = Calendar.current.weekdaySymbols.count
        
        barDebtChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barDebtChartView.data = BarChartData(dataSet: chartDataSet)
        barDebtChartView.xAxis.labelPosition = .bottom
        
        barDebtChartView.leftAxis.enabled = true
        barDebtChartView.leftAxis.labelCount = Int(4)
        barDebtChartView.pinchZoomEnabled = false
        barDebtChartView.rightAxis.enabled = false
        barDebtChartView.drawGridBackgroundEnabled = false
        barDebtChartView.chartDescription?.enabled = false
        
        let midLimitLine = ChartLimitLine(limit: midLimitTime, label: "注意水準")
        barDebtChartView.leftAxis.addLimitLine(midLimitLine)
        
        let highLimitLine = ChartLimitLine(limit: highLimitTime, label: "危険水準")
        barDebtChartView.leftAxis.addLimitLine(highLimitLine)
        
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        //力技で7種類の色を指定している = グラフ横軸の要素数がmax 7個。
        chartDataSet.colors = [setColor(value: y[0]),setColor(value: y[1]),setColor(value: y[2]),setColor(value: y[3]),setColor(value: y[4]),setColor(value: y[5]),setColor(value: y[6])]
        
        barDebtChartView.backgroundColor = UIColor.white
        barDebtChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    //仮のしきい値
    func setColor(value: Double) -> UIColor{
        if(value < midLimitTime){ return UIColor.green }
        else if(value <= highLimitTime && value >= midLimitTime){ return UIColor.yellow }
        else if(value > highLimitTime){ return UIColor.red }
        else { return UIColor.black }
    }
    
    public class BarChartFormatter: NSObject, IAxisValueFormatter{
        var weeks: [String]! = ["月","火","水","木","金","土","日"]
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // 0 -> 月, 1 -> 火...
            return weeks[Int(value)]
        }
    }
    //Merged

}
