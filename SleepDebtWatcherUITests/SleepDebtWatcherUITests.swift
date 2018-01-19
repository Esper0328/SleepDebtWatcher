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
    
    func testTopView_Exist() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let bedtimeInputButton = app.buttons["bedtimeInputButton"]
        let sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]
        let bedtimePlanButton = app.buttons["bedtimePlanButton"]

        XCTAssertTrue(bedtimeInputButton.exists)
        XCTAssertTrue(sleepDebtDisplayButton.exists)
        XCTAssertTrue(bedtimePlanButton.exists)
        
        //Below Test fails because UI Test doesn't care storyboard
        //XCTAssertEqual(bedtimeInputButton.title, "Input Bedtime")
    }
    
    func testBedtimePlanView_Exist(){
        let app = XCUIApplication()
        let bedtimePlanButton = app.buttons["bedtimePlanButton"]
        bedtimePlanButton.tap()
        
        let bedtimePlanDatePicker = app.datePickers["bedtimePlanDatePicker"]
        let bedtimePlanViewLabel = app.staticTexts["bedtimePlanViewLabel"]
        let timePlanSlotLabel = app.staticTexts["timePlanSlotLabel"]
        let timePlanCheckLabel = app.staticTexts["timePlanCheckLabel"]
        let backToTopFromBedtimePlanButton = app.buttons["backToTopFromBedtimePlanButton"]
        let bedtimeSetButton = app.buttons["bedtimePlanSetButton"]
        
        XCTAssertTrue(bedtimePlanDatePicker.exists)
        XCTAssertTrue(bedtimePlanViewLabel.exists)
        XCTAssertTrue(timePlanSlotLabel.exists)
        XCTAssertTrue(timePlanCheckLabel.exists)
        XCTAssertTrue(backToTopFromBedtimePlanButton.exists)
        XCTAssertTrue(bedtimeSetButton.exists)
    }

    func testBedtimeInputView_Exist() {
        let app = XCUIApplication()
        let bedtimeInputButton = app.buttons["bedtimeInputButton"]
        bedtimeInputButton.tap()
        
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
    }
    
    func testSleepDebtView_Exist(){
        let app = XCUIApplication()
        let sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]
        sleepDebtDisplayButton.tap()
        
        let sleepDebtViewLabel = app.staticTexts["sleepDebtViewLabel"]
        let sleepStateLabel = app.staticTexts["sleepStateLabel"]
        let sleepStateValueLabel = app.staticTexts["sleepStateValueLabel"]
        let sleepDebtLabel = app.staticTexts["sleepDebtLabel"]
        let sleepDebtValueLabel = app.staticTexts["sleepDebtValueLabel"]
        let sleepDebtUnitLabel = app.staticTexts["sleepDebtUnitLabel"]
        let backToTopFromSleepDebtButton = app.buttons["backToTopFromSleepDebtButton"]
        
        XCTAssertTrue(sleepDebtViewLabel.exists)
        XCTAssertTrue(sleepStateLabel.exists)
        XCTAssertTrue(sleepStateValueLabel.exists)
        XCTAssertTrue(sleepDebtLabel.exists)
        XCTAssertTrue(sleepDebtValueLabel.exists)
        XCTAssertTrue(sleepDebtUnitLabel.exists)
        XCTAssertTrue(backToTopFromSleepDebtButton.exists)
    }
    
    func testGoAndBackEachViewFromTopView(){
        let app = XCUIApplication()
        let bedtimePlanButton = app.buttons["bedtimePlanButton"]
        let bedtimeInputButton = app.buttons["bedtimeInputButton"]
        let sleepDebtDisplayButton = app.buttons["sleepDebtDisplayButton"]
        
        let backToTopFromBedtimeInputButton = app.buttons["backToTopFromBedtimeInput"]
        let backToTopFromBedtimePlanButton = app.buttons["backToTopFromBedtimePlanButton"]
        let backToTopFromSleepDebtButton = app.buttons["backToTopFromSleepDebtButton"]
        
        bedtimePlanButton.tap()
        backToTopFromBedtimePlanButton.tap()
        
        bedtimeInputButton.tap()
        backToTopFromBedtimeInputButton.tap()
        
        sleepDebtDisplayButton.tap()
        backToTopFromSleepDebtButton.tap()
        
    }


}
