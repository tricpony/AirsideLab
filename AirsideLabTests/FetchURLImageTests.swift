//
//  FetchURLImageTests.swift
//  AirsideLabTests
//
//  Created by aarthur on 8/6/19.
//  Copyright © 2019 Gigabit LLC. All rights reserved.
//

import XCTest
@testable import AirsideLab

class FetchURLImageTests: XCTestCase {
    
    func testFetchURLImagePass() {
        guard let url = URL(string: "https://avatars2.githubusercontent.com/u/371835?v=4") else { XCTFail("Bad URL"); return }
        let expectation = XCTestExpectation(description: "Wait for service.")
        URLImage.fetchImageURL(url) { result in
            switch result {
            case .success(let image):
                expectation.fulfill()
                XCTAssertNotNil(image)
            case .failure:
                return
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFetchURLImageFail() {
        guard let url = URL(string: "https://avatars2.githubuserontent.com/u/371835?v=4") else { XCTFail("Bad URL"); return }
        let expectation = XCTestExpectation(description: "Wait for service.")
        URLImage.fetchImageURL(url) { result in
            switch result {
            case .success(let image):
                expectation.fulfill()
                XCTAssertNil(image)
            case .failure(let error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
