//
//  SleepDebtWatcherTests.swift
//  SleepDebtWatcherTests
//
//  Created by Yohei Kato on 2018/01/06.
//  Copyright © 2018年 Yohei Kato. All rights reserved.
//

import XCTest
@testable import SleepDebtWatcher

class SleepDebtWatcherTests: XCTestCase {
    let bedtimeInputView = BedtimeInputViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func initBedtimeInputViewController(rv_timeOfSleep: DateComponents, rv_wakeTime:DateComponents){
        bedtimeInputView.setTimeOfSleep(rv_timeOfSleep: rv_timeOfSleep)
        bedtimeInputView.setWakeTime(rv_wakeTime: rv_wakeTime)
    }
    
    func initBedtimeInputViewControllerWithCalcBedtime(rv_timeOfSleep: DateComponents, rv_wakeTime:DateComponents){
        initBedtimeInputViewController(rv_timeOfSleep: rv_timeOfSleep, rv_wakeTime:rv_wakeTime)
        bedtimeInputView.calcBedtime()
    }
    
    func initBedtimeInputViewControllerWithCalcSleepDebt(rv_timeOfSleep: DateComponents, rv_wakeTime:DateComponents){
        initBedtimeInputViewController(rv_timeOfSleep: rv_timeOfSleep, rv_wakeTime:rv_wakeTime)
        bedtimeInputView.calcSleepDebt()
    }
    
    func testSetTimeOfSleep_normalTime_setTimeOfSleep(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(rv_timeOfSleep: timeOfSleep)
        XCTAssert(bedtimeInputView.timeOfSleep == timeOfSleep)
    }

    func testSetWakeTime_normalTime_setWakeTime(){
        let bedtimeInputView = BedtimeInputViewController()
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setWakeTime(rv_wakeTime: wakeTime)
        XCTAssert(bedtimeInputView.wakeTime == wakeTime)
    }
    
    func testIsValidBedtime_validTime_returnTrue(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        initBedtimeInputViewController(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertTrue(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalidSameTime_returnFalse(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        initBedtimeInputViewController(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalidReversedTime_returnFalse(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        initBedtimeInputViewController(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testCalcBedtime_validTime_hourCalculated(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let bedtime = 9.0
        initBedtimeInputViewControllerWithCalcBedtime(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.bedtime, bedtime)
    }
    
    func testCalcBedtime_validTime_hourAndMinuteCalculated(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 25)
        let bedtime = 8.5

        initBedtimeInputViewControllerWithCalcBedtime(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.bedtime, bedtime)
    }
    
    func testCalcBedtime_invalidSameTime_hourAndMinuteAreZero(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        initBedtimeInputViewControllerWithCalcBedtime(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.bedtime, 0.0)
    }
    
    func testCalcBedtime_invalidReversedTime_hourAndMinuteAreZero() {
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        initBedtimeInputViewControllerWithCalcBedtime(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.bedtime, 0.0)
    }
    func testCalcSleepDebt_lessThanThresh_sleepDebtIncreased(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 4, minute: 55)
        let sleepDebt = 1.0
        initBedtimeInputViewControllerWithCalcSleepDebt(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.sleepDebt, sleepDebt)
    }
    
    func testCalcSleepDebt_equalsThresh_sleepDebtIsSame(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let sleepDebt = 0.0
        initBedtimeInputViewControllerWithCalcSleepDebt(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.sleepDebt, sleepDebt)
    }
    
    func testCalcSleepDebt_moreThanThresh_sleepDebtDecreased(){
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 8, minute: 55)
        let sleepDebt = 0.0
        initBedtimeInputViewControllerWithCalcSleepDebt(rv_timeOfSleep: timeOfSleep, rv_wakeTime: wakeTime)
        XCTAssertEqual(bedtimeInputView.sleepDebt, sleepDebt)
    }

    func testSetSleepDebt_SundaySleepDebt_setValue1(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        let Sunday:Int = 0
        let sleepDebt:Double = 1.0
        sleepDebtHistoryView.setSleepDebt(weekday: Sunday, rv_sleepDebt: sleepDebt)
        XCTAssertEqual(sleepDebtHistoryView.sleepDebt[Sunday], 1.0)
    }
    
    func testSetSleepDebt_SaturdaySleepDebt_setValue2(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        let Saturday:Int = 6
        let sleepDebt:Double = 2.0
        sleepDebtHistoryView.setSleepDebt(weekday: Saturday, rv_sleepDebt: sleepDebt)
        XCTAssertEqual(sleepDebtHistoryView.sleepDebt[Saturday], 2.0)
    }
    
    func testReverse_2LeftShift_2LeftShiftFromInput(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        var input_array = [10,20,30,40,50,60,70]
        let output_array = [30,40,50,60,70,10,20]
        let shift = 2
        sleepDebtHistoryView.rotate(input_data: &input_array, shift: shift)
        XCTAssertEqual(input_array, output_array)
    }
    
    func testReverse_minus2LeftShift_2LeftShiftFromInput(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        var input_array = [10,20,30,40,50,60,70]
        let output_array = [60,70,10,20,30,40,50]
        let shift = -2
        sleepDebtHistoryView.rotate(input_data: &input_array, shift: shift)
        XCTAssertEqual(input_array, output_array)
    }

    func testReverse_0LeftShift_SameValue(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        var input_array = [10,20,30,40,50,60,70]
        let output_array = [10,20,30,40,50,60,70]
        let shift = 0
        sleepDebtHistoryView.rotate(input_data: &input_array, shift: shift)
        XCTAssertEqual(input_array, output_array)
    }
    
    func testReverse_9LeftShift_2LeftShiftFromInput(){
        let sleepDebtHistoryView = SleepDebtHistoryViewController()
        var input_array = [10,20,30,40,50,60,70]
        let output_array = [30,40,50,60,70,10,20]
        let shift = 9
        sleepDebtHistoryView.rotate(input_data: &input_array, shift: shift)
        XCTAssertEqual(input_array, output_array)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
