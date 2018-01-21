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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGoAndBackEachViewFromTopView(){
        let app = XCUIApplication()
        let wait_time = 1.0
        
        //Test Topview
        let bedtimePlanButton = app.buttons["bedtimePlanButton"]
        let bedtimeInputButton = app.buttons["bedtimeInputButton"]
        let sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]
        
        XCTAssertTrue(bedtimeInputButton.exists)
        XCTAssertTrue(sleepDebtDisplayButton.exists)
        XCTAssertTrue(bedtimePlanButton.exists)
        
        //Test TopView<->BedtimePlanView
        bedtimePlanButton.tap()                             //TopView->BedtimePlanView
        let bedtimePlanDatePicker = app.datePickers["bedtimePlanDatePicker"]
        let bedtimePlanViewLabel = app.staticTexts["bedtimePlanViewLabel"]
        let timePlanSlotLabel = app.staticTexts["timePlanSlotLabel"]
        let timePlanCheckLabel = app.staticTexts["timePlanCheckLabel"]
        let backToTopFromBedtimePlanButton = app.buttons["backToTopFromBedtimePlanButton"]
        let bedtimePlanSetButton = app.buttons["bedtimePlanSetButton"]
        
        XCTAssertTrue(bedtimePlanDatePicker.exists)
        XCTAssertTrue(bedtimePlanViewLabel.exists)
        XCTAssertTrue(timePlanSlotLabel.exists)
        XCTAssertTrue(timePlanCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimePlanButton.exists)
        XCTAssertTrue(bedtimePlanSetButton.exists)
        
        backToTopFromBedtimePlanButton.tap()                //BedtimePlanView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        
        //Test TopView<->BedtimeInputView
        bedtimeInputButton.tap()                            //TopView->BedtimeInputView
        Thread.sleep(forTimeInterval: wait_time)
        
        let bedtimeDatePicker = app.datePickers["bedtimeDatePicker"]
        let bedtimeInputViewLabel = app.staticTexts["bedtimeInputViewLabel"]
        let timeSlotLabel = app.staticTexts["timeSlotLabel"]
        let timeInputCheckLabel = app.staticTexts["timeInputCheckLabel"]
        let backToTopFromBedtimeInputButton = app.buttons["backToTopFromBedtimeInput"]
        let bedtimeSetButton = app.buttons["bedtimeSetButton"]
        
        XCTAssertTrue(bedtimeDatePicker.exists)
        XCTAssertTrue(bedtimeInputViewLabel.exists)
        XCTAssertTrue(timeSlotLabel.exists)
        XCTAssertTrue(timeInputCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimeInputButton.exists)
        XCTAssertTrue(bedtimeSetButton.exists)
        
        
        
        backToTopFromBedtimeInputButton.tap()               //BedtimeInputView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        
        //Test TopView<->SleepDebtHistoryView
        sleepDebtDisplayButton.tap()                        //TopView->SleepDebtHistoryView
        Thread.sleep(forTimeInterval: wait_time)
        
        let sleepDebtViewLabel = app.staticTexts["sleepDebtViewLabel"]
        let sleepStateLabel = app.staticTexts["sleepStateLabel"]
        let sleepStateValueLabel = app.staticTexts["sleepStateValueLabel"]
        let sleepDebtLabel = app.staticTexts["sleepDebtLabel"]
        let sleepDebtValueLabel = app.staticTexts["sleepDebtValueLabel"]
        let sleepDebtUnitLabel = app.staticTexts["sleepDebtUnitLabel"]
        let backToTopFromSleepDebtButton = app.buttons["backToTopFromSleepDebtButton"]
        let barChartViewLabel = app.staticTexts["barChartViewLabel"]
        
        barChartViewLabel.tap()
        
        XCTAssertTrue(sleepDebtViewLabel.exists)
        XCTAssertTrue(sleepStateLabel.exists)
        XCTAssertTrue(sleepStateValueLabel.exists)
        XCTAssertTrue(sleepDebtLabel.exists)
        XCTAssertTrue(sleepDebtValueLabel.exists)
        XCTAssertTrue(sleepDebtUnitLabel.exists)
        XCTAssertTrue(backToTopFromSleepDebtButton.exists)
        backToTopFromSleepDebtButton.tap()                  //SleepDebtHistoryView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        
        //Test TopView->BedtimeInputView->SleepDebtHistoryView->TopView
        bedtimeInputButton.tap()                            //TopView->BedtimeInputView
        XCTAssertEqual(timeSlotLabel.label, "就寝時間")
        
        //timeOfSleep = DateComponents(year: 2017, month: 1, day: 17, hour: 21, minute: 55)
        //wakeTime = DateComponents(year: 2017, month: 1, day: 18, hour: 4, minute: 55)
        
        //Set Sleep Of Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 17")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "PM")
        Thread.sleep(forTimeInterval: wait_time)
        bedtimeSetButton.tap()
        XCTAssertEqual(timeSlotLabel.label, "起床時間")
        Thread.sleep(forTimeInterval: wait_time)
        
        //Set Wake Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 18")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "4")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "AM")

        bedtimeSetButton.tap()                              //BedtimeInputView->SleepDebtHistoryView
        
        XCTAssertEqual(sleepDebtValueLabel.label, "1")
        
        //TODO test SleepDebt
        backToTopFromSleepDebtButton.tap()                  //SleepDebtHistoryView->TopVie
        Thread.sleep(forTimeInterval: wait_time)
    }


}
