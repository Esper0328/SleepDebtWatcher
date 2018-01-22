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
    var sleepDebtValue: Int! = 0
    var weekdayOfCalcBedtime:Int = 0
    
    //Merged
    var test_data = [10.0,20.0,30.0,40.0,55.0,63.0,70.5]
    let highLimitTime = 40.0
    let midLimitTime = 20.0
    let weeks: [String]! = ["月","火","水","木","金","土","日"]
    var now_week : Int = 2  //今日の曜日  月曜:0, 火曜:1, 水曜:2, 木曜:3, 金曜:4, 土曜:5, 日曜:6 <- conflicted with Calendar API
    //Merged
    
    @IBOutlet weak var barDebtChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepDebtValueLabel.text = String(sleepDebtValue)
        setChart(y: test_data, week:now_week)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Merged
    func setChart(y: [Double], week:Int) {
        //今日を起点とした曜日情報の数字
        //var hoge:Int
        //hoge = y[0] % 7.0
        
        // y軸
        var dataEntries = [BarChartDataEntry]()
        
        for (i, val) in y.enumerated() {
            //hoge = (i + week + 7) % 7
            let dataEntry = BarChartDataEntry(x: Double(i), y: val)
            //let dataEntry = BarChartDataEntry(x: Double(hoge), y: val)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "ふさい")
        let xaxis = XAxis()
        xaxis.valueFormatter = BarChartFormatter()
        barDebtChartView.xAxis.labelCount = Calendar.current.weekdaySymbols.count
        //chartDataSet.label = "曜日"
        
        barDebtChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barDebtChartView.data = BarChartData(dataSet: chartDataSet)
        // x軸のラベルをボトムに表示
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
        
        //barDebtView.leftAxis.labelPosition
        
        // グラフの色
        //chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        //力技で7種類の色を指定している = グラフ横軸の要素数がmax 7個。
        chartDataSet.colors = [setColor(value: y[0]),setColor(value: y[1]),setColor(value: y[2]),setColor(value: y[3]),setColor(value: y[4]),setColor(value: y[5]),setColor(value: y[6])]
        
        // グラフの背景色
        //barDebtView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barDebtChartView.backgroundColor = UIColor.white
        // アニメーション
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
