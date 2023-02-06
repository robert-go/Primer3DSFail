//
//  Primer3DSFailUITests.swift
//  Primer3DSFailUITests
//
//  Created by Golden Owl on 06/02/2023.
//

import XCTest

final class Primer3DSFailUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPrimerCheckout() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        let exists = NSPredicate(format: "exists == 1")

        let checkoutButton = app/*@START_MENU_TOKEN@*/ .staticTexts["Checkout"]/*[[".buttons[\"Checkout\"].staticTexts[\"Checkout\"]",".staticTexts[\"Checkout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expectation(for: exists, evaluatedWith: checkoutButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        checkoutButton.tap()

        let elementsQuery = app.scrollViews["primer_container_scroll_view"].otherElements

        let cardTxtFldTextField = elementsQuery.textFields["card_txt_fld"]

        expectation(for: exists, evaluatedWith: cardTxtFldTextField, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        cardTxtFldTextField.tap()
        cardTxtFldTextField.typeText("9120000000000006")

        let expiryTxtFldTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["expiry_txt_fld"]/*[[".textFields[\"12\/24\"]",".textFields[\"expiry_txt_fld\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        expiryTxtFldTextField.tap()
        expiryTxtFldTextField.typeText("0124")

        let cvcTxtFldTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["cvc_txt_fld"]/*[[".textFields[\"123\"]",".textFields[\"cvc_txt_fld\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cvcTxtFldTextField.tap()
        cvcTxtFldTextField.typeText("123")

        let cardHolderTxtFldTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["card_holder_txt_fld"]/*[[".textFields[\"e.g. John Doe\"]",".textFields[\"card_holder_txt_fld\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cardHolderTxtFldTextField.tap()
        cardHolderTxtFldTextField.typeText("John")

        elementsQuery/*@START_MENU_TOKEN@*/ .buttons["submit_btn"]/*[[".buttons[\"Pay $0.00\"]",".buttons[\"submit_btn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        snapshot("01-PrimerScreen")
        let selectOutcome = app.staticTexts["Select outcome"]
        sleep(10)
        snapshot("02-PrimerScreen")
        expectation(for: exists, evaluatedWith: selectOutcome, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
    }
}
