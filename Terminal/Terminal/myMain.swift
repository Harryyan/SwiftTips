//
//  main.swift
//  Terminal
//
//  Created by Harry Yan on 11/08/21.
//

import Foundation

func fetchAndDecode<T: Decodable>(url: URL) async throws -> T {
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedData = try JSONDecoder().decode(T.self, from: data)
    
    return decodedData
}

func fetchCurrency<T: Decodable>(url: URL) async throws -> T {
    let task = Task { () -> T in
        try await fetchAndDecode(url: url)
    }
    
    return try await task.value
}


@main
struct Main {
    static func main() async throws {
        
        let value: CurrencyResponse = try await fetchCurrency(url: CurrencyResponse.url)
        
        print(value)
        
        
        
        
        
        
        
        
        
        
        
        
//        //        let cache = HashCache()
//        //        await cache.compute()
//        //
//        let buffer = Buffer()
//
//        //        await cache.addHash(for: 3)
//        //        await cache.compute()
//        //
//        //        print(await cache.hashes)
//
//
//
//        await withTaskGroup(of: Bool.self) { group in
//            // Producer
//            for i in 0 ... 100 {
//                group.addTask() {
//                    await buffer.add(i)
//                    return true
//                }
//
//                print("########")
//
//                group.addTask() {
//                    await buffer.remove()
//                    return true
//                }
//
//                print("*********")
//            }
//        }
    }
}
