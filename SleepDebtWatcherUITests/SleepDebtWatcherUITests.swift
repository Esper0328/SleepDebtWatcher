//
//  SleepDebtWatcherUITests.swift
//  SleepDebtWatcherUITests
//
//  Created by Yohei Kato on 2018/01/06.
//  Copyright © 2018年 Yohei Kato. All rights reserved.
//

import XCTest
@testable import SleepDebtWatcher

class SleepDebtWatcherUITests: XCTestCase {

    let app = XCUIApplication()
    let no_wait = 0.0
    
    //TopViewController
    var bedtimePlanButton: XCUIElement!
    var bedtimeInputButton: XCUIElement!
    var sleepDebtDisplayButton: XCUIElement!
    
    //BedtimePlanViewController
    var bedtimePlanDatePicker: XCUIElement!
    var bedtimePlanViewLabel: XCUIElement!
    var timePlanSlotLabel: XCUIElement!
    var timePlanCheckLabel: XCUIElement!
    var backToTopFromBedtimePlanButton: XCUIElement!
    var bedtimePlanSetButton: XCUIElement!
    
    //BedtimeInputViewController
    var bedtimeDatePicker: XCUIElement!
    var bedtimeInputViewLabel: XCUIElement!
    var timeSlotLabel: XCUIElement!
    var timeInputCheckLabel: XCUIElement!
    var backToTopFromBedtimeInputButton: XCUIElement!
    var bedtimeSetButton: XCUIElement!
    
    //SleepDebtHistoryViewController
    var sleepDebtViewLabel: XCUIElement!
    var sleepStateLabel: XCUIElement!
    var sleepStateValueLabel: XCUIElement!
    var sleepDebtLabel: XCUIElement!
    var sleepDebtValueLabel: XCUIElement!
    var sleepDebtUnitLabel: XCUIElement!
    var backToTopFromSleepDebtButton: XCUIElement!
    var barDebtChartView: XCUIElement!
    var resetSleepDebtButton: XCUIElement!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        //TopViewController
        bedtimePlanButton = app.buttons["bedtimePlanButton"]
        bedtimeInputButton = app.buttons["bedtimeInputButton"]
        sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]

        //BedtimeInputViewController
        bedtimeDatePicker = app.datePickers["bedtimeDatePicker"]
        bedtimeInputViewLabel = app.staticTexts["bedtimeInputViewLabel"]
        timeSlotLabel = app.staticTexts["timeSlotLabel"]
        timeInputCheckLabel = app.staticTexts["timeInputCheckLabel"]
        backToTopFromBedtimeInputButton = app.buttons["backToTopFromBedtimeInput"]
        bedtimeSetButton = app.buttons["bedtimeSetButton"]

        //SleepDebtHistoryViewController
        sleepDebtViewLabel = app.staticTexts["sleepDebtViewLabel"]
        sleepStateLabel = app.staticTexts["sleepStateLabel"]
        sleepStateValueLabel = app.staticTexts["sleepStateValueLabel"]
        sleepDebtLabel = app.staticTexts["sleepDebtLabel"]
        sleepDebtValueLabel = app.staticTexts["sleepDebtValueLabel"]
        sleepDebtUnitLabel = app.staticTexts["sleepDebtUnitLabel"]
        backToTopFromSleepDebtButton = app.buttons["backToTopFromSleepDebtButton"]
        barDebtChartView = app.staticTexts["barDebtChartViewLabel"]
        resetSleepDebtButton = app.buttons["resetSleepDebtButton"]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func initialize(){
        //reset UserDefaults
        tapAndWait(button: sleepDebtDisplayButton, wait_time: no_wait)
        tapAndWait(button: resetSleepDebtButton, wait_time: no_wait)
        tapAndWait(button: backToTopFromSleepDebtButton, wait_time: no_wait)
    }

    func testAllUI(){
        initialize()//reset UserDefaults
        goAndBackEachViewFromTopViewTest()
        bedtimePlanTest(sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",wake_hour : "4", wake_minute : "55", wake_AMorPM : "AM")
        
        bedtimeInputTest(sleep_date : "Jan 17", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 18", wake_hour : "2", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "3.0")
        bedtimeInputTest(sleep_date : "Jan 18", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 19", wake_hour : "1", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "7.0")
        bedtimeInputTest(sleep_date : "Jan 19", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 20", wake_hour : "5", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "7.0")
        bedtimeInputTest(sleep_date : "Jan 20", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 21", wake_hour : "8", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "4.0")
        bedtimeInputTest(sleep_date : "Jan 21", sleep_hour : "8", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 22", wake_hour : "8", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "0.0")
        bedtimeInputTest(sleep_date : "Jan 22", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 23", wake_hour : "6", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "0.0")
        bedtimeInputTest(sleep_date : "Jan 23", sleep_hour : "9", sleep_minute : "55", sleep_AMorPM : "PM",
                         wake_date : "Jan 24", wake_hour : "4", wake_minute : "55", wake_AMorPM : "AM", sleepDebtValue: "1.0")
    }
    
    func goAndBackEachViewFromTopViewTest() {
        topViewControllerComponentsExistTest()
        tapAndWait(button: bedtimePlanButton, wait_time: no_wait)               //TopView->BedtimePlanView
        bedtimeInputViewExistTest()
        XCTAssertEqual(bedtimeInputViewLabel.label, "起床・就寝予定入力モード")
        
        tapAndWait(button: backToTopFromBedtimeInputButton, wait_time: no_wait) //BedtimePlanView->TopView
        tapAndWait(button: bedtimeInputButton, wait_time: no_wait)              //TopView->BedtimeInputView
        XCTAssertEqual(bedtimeInputViewLabel.label, "起床・就寝結果入力モード")
        
        tapAndWait(button: backToTopFromBedtimeInputButton, wait_time: no_wait) //BedtimeInputView->TopView
        tapAndWait(button: sleepDebtDisplayButton, wait_time: no_wait)          //TopView->SleepDebtHistoryView
        
        barDebtChartView.tap()                                                  //DummyTest to avoid warning
        sleepDebtHistoryViewControllerComponentsExistTest()
        tapAndWait(button: backToTopFromSleepDebtButton, wait_time: no_wait)    //SleepDebtHistoryView->TopView
    }
    
    func topViewControllerComponentsExistTest(){
        XCTAssertTrue(bedtimeInputButton.exists)
        XCTAssertTrue(sleepDebtDisplayButton.exists)
        XCTAssertTrue(bedtimePlanButton.exists)
    }
    
    func bedtimeInputViewExistTest(){
        XCTAssertTrue(bedtimeDatePicker.exists)
        XCTAssertTrue(bedtimeInputViewLabel.exists)
        XCTAssertTrue(timeSlotLabel.exists)
        XCTAssertTrue(timeInputCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimeInputButton.exists)
        XCTAssertTrue(bedtimeSetButton.exists)
    }

    func sleepDebtHistoryViewControllerComponentsExistTest(){
        XCTAssertTrue(sleepDebtViewLabel.exists)
        XCTAssertTrue(sleepStateLabel.exists)
        XCTAssertTrue(sleepStateValueLabel.exists)
        XCTAssertTrue(sleepDebtLabel.exists)
        XCTAssertTrue(sleepDebtValueLabel.exists)
        XCTAssertTrue(sleepDebtUnitLabel.exists)
        XCTAssertTrue(backToTopFromSleepDebtButton.exists)
        XCTAssertTrue(resetSleepDebtButton.exists)
    }
    
    func bedtimePlanTest(sleep_hour: String, sleep_minute: String, sleep_AMorPM: String, wake_hour: String, wake_minute: String, wake_AMorPM: String){
        tapAndWait(button: bedtimePlanButton, wait_time: no_wait)
        XCTAssertEqual(timeSlotLabel.label, "就寝時間")
        //Set Sleep Of Time
        setbedtimePickerAndWait(hour: sleep_hour, minute: sleep_minute, AMorPM: sleep_AMorPM, wait_time: no_wait)
        tapAndWait(button: bedtimeSetButton, wait_time: no_wait)
        XCTAssertEqual(timeSlotLabel.label, "起床時間")
        
        //Set Wake Time
        setbedtimePickerAndWait(hour: wake_hour, minute: wake_minute, AMorPM: wake_AMorPM, wait_time: no_wait)
        tapAndWait(button: bedtimeSetButton, wait_time: no_wait)
    }
    
    func bedtimeInputTest(sleep_date: String, sleep_hour: String, sleep_minute: String, sleep_AMorPM: String,
                          wake_date: String, wake_hour: String, wake_minute: String, wake_AMorPM: String, sleepDebtValue: String){
        tapAndWait(button: bedtimeInputButton, wait_time: no_wait)
        XCTAssertEqual(timeSlotLabel.label, "就寝時間")
        //Set Sleep Of Time
        setbedtimeDatePickerAndWait(date: sleep_date, hour: sleep_hour, minute: sleep_minute, AMorPM: sleep_AMorPM, wait_time: no_wait)
        tapAndWait(button: bedtimeSetButton, wait_time: no_wait)
        XCTAssertEqual(timeSlotLabel.label, "起床時間")
        
        //Set Wake Time
        setbedtimeDatePickerAndWait(date: wake_date, hour: wake_hour, minute: wake_minute, AMorPM: wake_AMorPM, wait_time: no_wait)
    
        tapAndWait(button: bedtimeSetButton, wait_time: no_wait)
        XCTAssertEqual(sleepDebtValueLabel.label, sleepDebtValue)
        tapAndWait(button: backToTopFromSleepDebtButton, wait_time: no_wait)
    }
    
    func setbedtimePickerAndWait(hour : String, minute : String, AMorPM : String, wait_time : Double){
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: hour)
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: minute)
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: AMorPM)
        Thread.sleep(forTimeInterval: wait_time)
    }
    
    func setbedtimeDatePickerAndWait(date : String, hour : String, minute : String, AMorPM : String, wait_time : Double){
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: date)
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: hour)
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: minute)
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: AMorPM)
        Thread.sleep(forTimeInterval: wait_time)
    }
    
    func tapAndWait(button: XCUIElement, wait_time: Double){
        button.tap()
        Thread.sleep(forTimeInterval: wait_time)
    }
}
