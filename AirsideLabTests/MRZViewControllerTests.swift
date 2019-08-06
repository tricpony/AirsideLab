//
//  MRZViewControllerTests.swift
//  AirsideLabTests
//
//  Created by aarthur on 8/6/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import XCTest
@testable import AirsideLab

class MRZViewControllerTests: XCTestCase {
    var mrzViewController: MRZViewController!
    var expectation: XCTestExpectation!
    let KVO_keyPath = "servicePassed"

    func loadMRZController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mrzViewController = storyboard.instantiateViewController(withIdentifier: "MRZ") as? MRZViewController
        _ = mrzViewController.view
        expectation = keyValueObservingExpectation(for: mrzViewController as Any, keyPath: KVO_keyPath, handler: nil)
    }

    func testDataSourceNotEmpty() {
        loadMRZController()
        mrzViewController.parseTapped(self)
        wait(for: [expectation], timeout: 3.0)
        XCTAssertGreaterThan(mrzViewController.gitHubUsers.count, 0)
    }
}
