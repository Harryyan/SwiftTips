//
//  HashCache.swift
//  HashCache
//
//  Created by Harry Yan on 11/08/21.
//

import CryptoKit
import Foundation

class HashCache {
    private(set) var hashes = [Int: String]()
    
    func addHash(for number: Int) async {
        let string = SHA512.hash(data: Data(String(number).utf8)
        ).description

        hashes[number] = string
        print(hashes)
    }
    
    func compute() async {
        print("start")
        
        for i in 0 ..< 10 {
            let test = Task {
                print(i)
            }
            
            // keep order
            print(await test.value)
        }
        
        //var test2 = await test.value
        
        print("end")
        
        
        //        DispatchQueue.concurrentPerform(iterations: 15,
        //                                        execute: addHash(for:))
    }
    
    static func test(_: @escaping @Sendable () async -> ()) {
        
    }
}


// global actor
@MainActor func save() {
    print("save")
}

//Allow synchronous access to actor’s members from within itself,
//Allow only asynchronous access to the actor’s members from any asynchronous context, and
//Allow only asynchronous access to the actor’s members from outside the actor.


actor HashCacheActor {
    private(set) var hashes = [Int: String]()
    
    func addHash(for number: Int) async {
        let string = SHA512.hash(data: Data(String(number).utf8)
        ).description
        
        hashes[number] = string
        
        print(hashes)
    }
    
    func compute() async {
        //        print(Thread.current)
        //        print("##")
        //        self.addHash(for: 23)
        //        self.addHash(for: 32)
        
        Task {
            // print("dsdfc")
            await self.addHash(for: 22)
            // print("***")
        }
        //
        
        //        HashCache.test {
        //            await self.addHash(for: 22)
        //        }
        
        //        DispatchQueue.concurrentPerform(iterations: 15000) { number in
        //            self.addHash(for: number)
        //          }
        //        await self.addHash(for: 22)
        
        //        await withTaskGroup(of: Bool.self) { group in
        //            //                    for number in 0 ... 15 {
        //            //                        group.addTask {
        //            //                            print(Thread.current)
        //            //                            await self.addHash(for: number)
        //            //                            return true
        //            //                        }
        //            //                    }
        //            Task {
        //                print(Thread.current)
        //                self.addHash(for: 22)
        //            }
        //
        ////            group.addTask {
        ////                for number in 0 ... 15 {
        ////                    print(Thread.current)
        ////                    await self.addHash(for: number)
        ////                }
        ////
        //                return true
        ////            }
        
        
        //        }
        
        // print(hashes)
    }
}
