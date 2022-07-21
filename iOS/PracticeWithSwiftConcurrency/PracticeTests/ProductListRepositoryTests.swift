//
//  PracticeTests.swift
//  PracticeTests
//
//  Created by Harry Yan on 18/07/22.
//

import XCTest
@testable import Practice

final class ProductListRepositoryTests: XCTestCase {

    func testLoadData_withoutError_shouldReturnTrue() async throws {
        var loader = MockDataLoader()
        loader.items = [Product(id: 1, title: "Test", description: "Desc1")]
        let repo = ProductListRepository(loader: loader)
        
        do {
            let result = try await repo.loadData(from: URL(string:"https://dummyjson.com/products")!)
            XCTAssertTrue(result.count == 1)
        } catch {
            XCTFail("Error happened!")
        }
    }
    
    func testLoadData_withError_shouldReturnTrue() throws {
        
    }
}

// Block ways
//// Asynchronous test: success fast, failure slow
//func testValidApiCallGetsHTTPStatusCode200() throws {
//  // given
//  let urlString =
//    "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
//  let url = URL(string: urlString)!
//  // 1





//  let promise = expectation(description: "Status code: 200")




//
//  // when
//  let dataTask = sut.dataTask(with: url) { _, response, error in
//    // then
//    if let error = error {
//      XCTFail("Error: \(error.localizedDescription)")
//      return
//    } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//      if statusCode == 200 {
//        // 2
//        promise.fulfill()
//      } else {
//        XCTFail("Status code: \(statusCode)")
//      }
//    }
//  }
//  dataTask.resume()
//  // 3
//  wait(for: [promise], timeout: 5)
//}
