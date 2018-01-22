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
    let wait_time = 0.0
    
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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //TopViewController
        bedtimePlanButton = app.buttons["bedtimePlanButton"]
        bedtimeInputButton = app.buttons["bedtimeInputButton"]
        sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]
        
        //BedtimePlanViewController
        bedtimePlanDatePicker = app.datePickers["bedtimePlanDatePicker"]
        bedtimePlanViewLabel = app.staticTexts["bedtimePlanViewLabel"]
        timePlanSlotLabel = app.staticTexts["timePlanSlotLabel"]
        timePlanCheckLabel = app.staticTexts["timePlanCheckLabel"]
        backToTopFromBedtimePlanButton = app.buttons["backToTopFromBedtimePlanButton"]
        bedtimePlanSetButton = app.buttons["bedtimePlanSetButton"]

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
        //Test TopView<->BedtimePlanView
        topViewControllerComponentsExist()
        bedtimePlanButton.tap()                             //TopView->BedtimePlanView
        Thread.sleep(forTimeInterval: wait_time)
        bedtimePlanViewControllerComponentsExist()
        backToTopFromBedtimePlanButton.tap()                //BedtimePlanView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        bedtimeInputButton.tap()                            //TopView->BedtimeInputView
        Thread.sleep(forTimeInterval: wait_time)
        bedtimeInputViewExist()
        backToTopFromBedtimeInputButton.tap()               //BedtimeInputView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        sleepDebtDisplayButton.tap()                        //TopView->SleepDebtHistoryView
        Thread.sleep(forTimeInterval: wait_time)
        barDebtChartView.tap()//Dummy to avoid warning
        sleepDebtHistoryViewControllerComponentsExist()
        backToTopFromSleepDebtButton.tap()                  //SleepDebtHistoryView->TopView
        Thread.sleep(forTimeInterval: wait_time)
        
        bedtimeInputButton.tap()
        XCTAssertEqual(timeSlotLabel.label, "就寝時間")
        
        //Set Sleep Of Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 17")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "PM")
        Thread.sleep(forTimeInterval: wait_time)
        bedtimeSetButton.tap()
        Thread.sleep(forTimeInterval: wait_time)
        XCTAssertEqual(timeSlotLabel.label, "起床時間")
        
        //Set Wake Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 18")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "4")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "AM")
        bedtimeSetButton.tap()
        XCTAssertEqual(sleepDebtValueLabel.label, "1")
        backToTopFromSleepDebtButton.tap()
        
        /*
        bedtimeInputButton.tap()
        XCTAssertEqual(timeSlotLabel.label, "就寝時間")
        
        //Set Sleep Of Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 17")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "9")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "PM")
        Thread.sleep(forTimeInterval: wait_time)
        bedtimeSetButton.tap()
        Thread.sleep(forTimeInterval: wait_time)
        XCTAssertEqual(timeSlotLabel.label, "起床時間")
        
        //Set Wake Time
        bedtimeDatePicker.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 18")
        bedtimeDatePicker.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "4")
        bedtimeDatePicker.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "55")
        bedtimeDatePicker.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "AM")
        bedtimeSetButton.tap()
        XCTAssertEqual(sleepDebtValueLabel.label, "1")
        backToTopFromSleepDebtButton.tap()
        */
        
    }
    
    func topViewControllerComponentsExist(){
        XCTAssertTrue(bedtimeInputButton.exists)
        XCTAssertTrue(sleepDebtDisplayButton.exists)
        XCTAssertTrue(bedtimePlanButton.exists)
    }
    
    func bedtimePlanViewControllerComponentsExist(){
        XCTAssertTrue(bedtimePlanDatePicker.exists)
        XCTAssertTrue(bedtimePlanViewLabel.exists)
        XCTAssertTrue(timePlanSlotLabel.exists)
        XCTAssertTrue(timePlanCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimePlanButton.exists)
        XCTAssertTrue(bedtimePlanSetButton.exists)
    }
    
    func bedtimeInputViewExist(){
        XCTAssertTrue(bedtimeDatePicker.exists)
        XCTAssertTrue(bedtimeInputViewLabel.exists)
        XCTAssertTrue(timeSlotLabel.exists)
        XCTAssertTrue(timeInputCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimeInputButton.exists)
        XCTAssertTrue(bedtimeSetButton.exists)
    }

    func sleepDebtHistoryViewControllerComponentsExist(){
        XCTAssertTrue(sleepDebtViewLabel.exists)
        XCTAssertTrue(sleepStateLabel.exists)
        XCTAssertTrue(sleepStateValueLabel.exists)
        XCTAssertTrue(sleepDebtLabel.exists)
        XCTAssertTrue(sleepDebtValueLabel.exists)
        XCTAssertTrue(sleepDebtUnitLabel.exists)
        XCTAssertTrue(backToTopFromSleepDebtButton.exists)
    }
}
