//
//  LocalStoreTests.swift
//  TiguerTests
//
//  Created by Bruce McTigue on 12/28/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import XCTest
@testable import Tiguer

class LocalStoreTests: XCTestCase {
    
    let assetName = "testJson"
    lazy var url = LocalDataUrlGenerator(Request()).url()
    var fetchedData: Data?
    var error: StoreError?
    
    func testLocalStore() {
        let expectation = self.expectation(description: "fetchData")
        let testBundle = Bundle(for: type(of: self))
        let sut = LocalStore(assetName, bundle: testBundle)
        
        sut.fetchData(url!).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                }
            case .error(let error):
                print(error)
            case .cancelled:
                print("cancelled")
            case .unresolved:
                print("unresolved")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(fetchedData)
        XCTAssertNil(error)
    }

    func testLocalStoreBadAsset() {
        let expectation = self.expectation(description: "fetchData")
        let testBundle = Bundle(for: type(of: self))
        let sut = LocalStore("badAssetName", bundle: testBundle)
        self.fetchedData = nil
        sut.fetchData(url!).finally { future in
            switch future.state {
            case .result(let storeResult):
                switch storeResult {
                case .success(let data):
                    self.fetchedData = data
                }
            case .error(let error):
                print(error.localizedDescription)
                self.error = error as? StoreError
            case .cancelled:
                XCTFail()
            case .unresolved:
                XCTFail()
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(error)
        XCTAssertNil(fetchedData)
    }
}
