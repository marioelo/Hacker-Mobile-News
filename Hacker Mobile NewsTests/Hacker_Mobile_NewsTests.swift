//
//  Hacker_Mobile_NewsTests.swift
//  Hacker Mobile NewsTests
//
//  Created by Mario Elorza on 10-05-21.
//

import XCTest
@testable import Hacker_Mobile_News

class Hacker_Mobile_NewsTests: XCTestCase {

    func testTimeAgoString() {
        let tenMinsAgo = Date(timeIntervalSinceNow: -1648 * 60)
        let tenMinsAgoString = tenMinsAgo.timeAgoString()
        XCTAssertEqual(tenMinsAgoString, "1d 3h 28m")
    }

}
