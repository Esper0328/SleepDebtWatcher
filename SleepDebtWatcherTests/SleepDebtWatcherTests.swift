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
    
    func testSetTimeOfSleep(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        XCTAssert(bedtimeInputView.timeOfSleep == timeOfSleep)
    }

    func testSetWakeTime(){
        let bedtimeInputView = BedtimeInputViewController()
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssert(bedtimeInputView.wakeTime == wakeTime)
    }
    
    func testIsValidBedtime_valid(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertTrue(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalid_zero(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testIsValidBedtime_invalid_inverted(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        XCTAssertFalse(bedtimeInputView.isValidBedtime())
    }
    
    func testCalcBedtime_hour(){
        let bedtimeInputView = BedtimeInputViewController()
        let timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        let wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 6, minute: 55)
        bedtimeInputView.setTimeOfSleep(_timeOfSleep: timeOfSleep)
        bedtimeInputView.setWakeTime(_wakeTime: wakeTime)
        let _bedtime_hour = 9
        bedtimeInputView.calcBedtime()
        XCTAssertEqual(bedtimeInputView.bedtime_hour, _bedtime_hour)
    }
    
    func testCalcBedtime_hour_minute(){
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
    
    //TODO:Consider naming convention
    //func testCalcBedtime_zero_from_sameinput()
    //func testCalcBedtime_zero_from_invertedinput()
    //func testCalcSleepDebt_()
    //func testCalcSleepDebt_()
    //func testCalcSleepDebt_()
    //func testCalcSleepDebt_()
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    
}
