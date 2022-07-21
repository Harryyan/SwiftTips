//
//  CashRegisterTests.swift
//  PracticeTests
//
//  Created by Harry Yan on 21/07/22.
//

import XCTest

class CashRegister {
    let availableFunds: Decimal
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal = cost
    }
}

class CashRegisterTests: XCTestCase {
    
    func testInitAvailableFunds_setsAvailableFunds() {
        // given
        let availableFunds = Decimal(100)
        
        // when
        let sut = CashRegister(availableFunds: availableFunds)
        
        // then
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addsCostToTransactionTotal() {
        // given
        let availableFunds = Decimal(100)
        let sut = CashRegister(availableFunds: availableFunds)
        
        let itemCost = Decimal(42)
        
        // when
        sut.addItem(itemCost)
        
        // then
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
}
