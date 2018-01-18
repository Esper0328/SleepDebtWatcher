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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSetTimeOfSleep_normalTime_setTimeOfSleep(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        XCTAssert(bedtimeInputView.timeOfSleep == timeOfSleep)
    }

    func testSetWakeTime_normalTime_setWakeTime(){
        let bedtimeInputView = BedtimeInputViewController()
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssert(bedtimeInputView.wakeTime == wakeTime)
    }
    
    func testIsValidBedtime_validTime_returnTrue(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertTrue(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalidSameTime_returnFalse(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalidReversedTime_returnFalse(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testCalcBedtime_validTime_hourCalculated(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        let _bedtime_hour = 9
        bedtimeInputView.calcBedtime()
        XCTAssertEqual(bedtimeInputView.bedtime_hour, _bedtime_hour)
    }
    
    func testCalcBedtime_validTime_hourAndMinuteCalculated(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 45)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        let _bedtime_hour = 8
        let _bedtime_minute = 50
        bedtimeInputView.calcBedtime()
        XCTAssertEqual(bedtimeInputView.bedtime_hour, _bedtime_hour)
        XCTAssertEqual(bedtimeInputView.bedtime_minute, _bedtime_minute)
    }
    
    func testCalcBedtime_invalidSameTime_hourAndMinuteAreZero(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        bedtimeInputView.calcBedtime()
        XCTAssertEqual(bedtimeInputView.bedtime_hour, 0)
        XCTAssertEqual(bedtimeInputView.bedtime_minute, 0)
    }
    
    func testCalcBedtime_invalidReversedTime_hourAndMinuteAreZero() {
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        bedtimeInputView.calcBedtime()
        XCTAssertEqual(bedtimeInputView.bedtime_hour, 0)
        XCTAssertEqual(bedtimeInputView.bedtime_minute, 0)
    }
    func testCalcSleepDebt_lessThanThresh_sleepDebtIncreased(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 4, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        let _sleepDebt_hour = 1
        bedtimeInputView.calcSleepDebt()
        XCTAssertEqual(bedtimeInputView.sleepDebt_hour, _sleepDebt_hour)
    }
    
    //func testCalcSleepDebt_equalsThresh_sleepDebtisSame()
    //func testCalcSleepDebt_moreThanThresh_sleepDebtDecreased()
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
