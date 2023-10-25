//
//  Generics.swift
//  RTSPStreamer
//
//  Created by Darren Hurst on 2023-01-25.
//

import Foundation


@available(iOS 15.0, *)
struct Generics {
    
    init(){}
    
    func testSwap() {
        //swapAny(<#T##a: &T##T#>, <#T##b: &T##T#>)
        //var z = "mess"
        //var y = "generic"
        //swapAny(&y, &z)
        let a = "this is a string"
        print(a)
    
        // other tests
        //a.testRegString()
        //let coordinates = findCoordinates([-1,3,5,-3], 0)
        testPalindrome()
    }
    
    func testPalindrome() {
        let str = "racecar"
        if (str.isPalindrome()) {
            print("isPalindrome : YES \(str)")
        } else {
            print("isPalindrome : NO")
        }
        
        func testextension(){
            var arr = ["racsecar", "abba"]
            if arr.hasPalindrome() {print("palindrome was found")}
        }
    }
    
    
    
    func findCoordinates<T: FloatingPoint, I: FloatingPoint>(_ nums: [T], _ target: I) -> (Int, Int) {
        for (index,num) in nums.enumerated() {
             let valueToFind = nums.firstIndex(of: -(num)) ?? 0
             if valueToFind > 0 {
                 return (index, valueToFind)
             }
         }
         return (0,0)
     }
    
    
    
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    func findStringInArray<T: Equatable>(of valueToFind: T, in array:[T]) -> String? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index.description
            }
        }
        return nil
    }
    
    
    
    
    func swapAny<T>(_ a: inout T, _ b: inout T) {
        let tempa = a
        b = a
        a = tempa
        testSwap()
    }
    
  
    
}
@available(iOS 15.0, *)
protocol Container {
    associatedtype Item
    //array stubs
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
@available(iOS 15.0, *)
extension Container where Item == String {
    func isPalindrome(_ item: Item) -> Bool {
        item == String(item.reversed())
    }
}
@available(iOS 15.0, *)
extension Container where Item == Array<String> {
   func hasPalindrome(_ item: Item) -> Bool {
        for index in 0..<count {
            let str: String = item[index]
            if str.isPalindrome() {
                return true
            }
        }
        return false
    }
}
@available(iOS 15.0, *)
extension Container where Item == Double{
    func lowestPrice() -> Double {
        var low: Double = 0
        for index in 0..<count {
            if ( !low.isZero ) {
                if (self[index] <= low) {
                    low = self[index]
                }
            } else {
                low = self[index]
            }
        }
        return low
    }
}
@available(iOS 15.0, *)
extension Container where Item == Double {
    //[77,88,99,88,77,66].average()
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

extension String {
    func Localized(str: String) -> String {
        //assets
        return String.localizedStringWithFormat(str, "comment for test")
    }
}
extension String {
   func isPalindrome() -> Bool {
        return self.lowercased() == String(self.lowercased().reversed())
    }
}
extension Array {
    mutating func hasPalindrome() -> Bool {
        for index in 0..<count {
            let str:String = self[index] as! String
            if str.isPalindrome() {
                return true
            }
        }
        return false
    }
}
 
struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
    
  
}
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
@available(iOS 15.0, *)
extension Container where Item: Equatable {  // Where the type alias is Equatable
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
 

}
extension String {
    func hashtags(in str: String) -> [ String ] {
        let words = str.components(separatedBy: .whitespacesAndNewlines)
        let tags = words.filter { $0.starts(with: "#") }
            return tags.map { $0.lowercased() }
    }
}
