//
//  CurrencyResponse.swift
//  CurrencyResponse
//
//  Created by Harry Yan on 16/08/21.
//

import Foundation

let APP_LINK = "http://api.currencylayer.com/live"
let APP_SECRET = "6952a3adccd6b83863ff515793cf0c0d"

struct CurrencyResponse: Decodable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: TimeInterval
    let source: String
    let quotes: [String: Double]
    
    // Hard code here
    static let url = URL(string: APP_LINK + "?access_key=\(APP_SECRET)" + "&currencies=NZD,USD")!
}
