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

    //ToDo
    //dealing with minute
    //add Test Case to calcSleepDebt for full test pass
    //design weekly data
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
