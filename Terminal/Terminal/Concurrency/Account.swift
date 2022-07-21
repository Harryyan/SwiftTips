//
//  Account.swift
//  Terminal
//
//  Created by Harry on 27/02/22.
//

import Foundation

actor BankAccount {
    
    private var balance = 1000
    
    func withdraw(_ amount: Int) async {
        guard await authorizeTransaction() else {
            return
        }
        print("✅ Transaction authorized: \(amount)")
        
        
        print("🤓 Check balance for withdrawal: \(amount)")
        
        guard canWithdraw(amount) else {
            print("🚫 Not enough balance to withdraw: \(amount)")
            return
        }
        
        balance -= amount
        
        print("💰 Account balance: \(balance)")
    }
    
    private func canWithdraw(_ amount: Int) -> Bool {
        return amount <= balance
    }
    
    private func authorizeTransaction() async -> Bool {
        try? await Task.sleep(nanoseconds: 1 * 1000000000)
        
        return true
    }
}

