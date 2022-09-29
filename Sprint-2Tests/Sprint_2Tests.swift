//
//  Sprint_2Tests.swift
//  Sprint-2Tests
//
//  Created by Capgemini-DA184 on 9/27/22.
//

import XCTest
@testable import Sprint_2

class Sprint_2Tests: XCTestCase {
    var model : SignUpViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = SignUpViewController()
    }
    func testIsValidName() {
        let wrongName = model.validateName(nameText: "Adaar")
            XCTAssertTrue(wrongName, "invalid name")
 
    }
    func testIsValidEmail() {
        let wrongName = model.validateEmail(emailIDText: "adarsh@gmail.com")
            XCTAssertTrue(wrongName, "invalid email")
 
    }
    func testIsValidNumber() {
        let wrongName = model.validateMobile(mobile: "9977554433")
            XCTAssertTrue(wrongName, "invalid Mobile No.")
 
    }
    func testIsValidPassword() {
        let wrongName = model.validatePassword(passwordText: "Adarsh@12")
            XCTAssertTrue(wrongName, "invalid Mobile No.")
 
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
