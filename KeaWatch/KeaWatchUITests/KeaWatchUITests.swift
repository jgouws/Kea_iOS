//
//  KeaWatchUITests.swift
//  KeaWatchUITests
//
//  Created by Mikey Kane on 28/07/17.
//  Copyright © 2017 Kea Takers. All rights reserved.
//

import XCTest

class KeaWatchUITests: XCTestCase {
        
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"KeaWatch.SelectPhotoView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        
        let galleryButton = app.buttons["Gallery"]
        galleryButton.tap()
        sleep(10)
        app.collectionViews["PhotosGridView"].cells["Photo, Landscape, March 13, 2011, 1:17 PM"].tap()
        
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        XCTAssert(element2.exists)

        
        
    }
    
    func testCameraButtonDisabled() {
        let app = XCUIApplication()
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if isCameraAvailable {
            XCTAssertTrue(app.buttons["Camera"].isEnabled)
        }
        else {
            XCTAssertFalse(app.buttons["Camera"].isEnabled)
        }
    }
    
}
