//  CodeFile.swift
//  TestAA
//
//  Created by 程祥贺 on 2019/7/9.
//  Copyright © 2019 程祥贺. All rights reserved.
//

import Foundation

@objc public class TestSolution: NSObject {
    @objc public static func test1() {
//        let l1 = ListNode(5)
////        l1.next = ListNode(4)
////        l1.next?.next = ListNode(3)
////
//        let l2 = ListNode(5)
////        l2.next = ListNode(6)
////        l2.next?.next = ListNode(4)
//
//        let l3 = Solution.addTwoNumbers(l1, l2)
//
//        print(l3 ?? "")
        
        
//        Solution.lengthOfLongestSubstring("pwwkew")
        let a:[Character] = ["c","a","b","c","a","b","d","c","a","b"]
        let b:[Character] = ["d","c","a","b"]

        TestBC.bm(a: a, n: a.count, b: b, m: b.count)
        
//        var suffix = Array.init(repeating: -1, count: b.count)
//        var prefix = Array.init(repeating: false, count: b.count)

//        Solution.generateGS(b: b, m: b.count, suffix: &suffix, prefix: &prefix)
     

    }
}

@objc public class ListNode: NSObject {
    @objc public var val: Int
    @objc public var next: ListNode?
    @objc public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

@objc public class Solution: NSObject {
    
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let count = nums.count
        ///0 暴力法 n^2 / 1
        for i in 0..<count {
            for j in i+1..<count {
                if nums[i] == target - nums[j] {
                    return [i,j]
                }
            }
        }
        
        
        /////1 hash dict n / n
//        var hashMap: Dictionary<Int,Int> = [:]
//        for i in 0..<count {
//            let needNum = target - nums[i]
//            if let j = hashMap[needNum] {
//                return [j, i]
//            }
//            hashMap[nums[i]] = i
//        }
        return []
    }
    
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        var setMap = Set<Character>()
        var maxNum = 0
        var characters = Array(s)
        let count = characters.count

        
//        for i in 0..<count {
//            setmap.removeAll()
//            maxNum = max(maxNum, setmap.count)
//
//            for j in i..<count {
//                if setmap.contains(characters[j]) {
//                    maxNum = max(maxNum, setmap.count)
//                    break
//                } else {
//                    setmap.insert(characters[j])
//                    if j == count-1 {
//                        maxNum = max(maxNum, setmap.count)
//                    }
//                }
//            }
//        }
        
        //滑动窗口1
//        var i = 0
//        var j = 0
//        while i < count, j < count {
//            if setMap.contains(characters[j]) == false {
//                setMap.insert(characters[j])
//                j += 1
//                maxNum = max(maxNum, j-i)
//            } else {
//                setMap.remove(characters[i])
//                i += 1
//            }
//        }
        
        //滑动窗口2
//        如果没有重复字符出现： 循环 游标end开始步进如果没有遇到重复字符ans为 （end - start ），
//        并用当前字符为Key记录当前 end 游标的index
//
//        有重复字符出现
//        1.如果碰到重复字符(从我们Hash记录中找到)
//        2.更新start游标移动至 重复字符的下标的后一位
//        3.取之前ans字符长度和现在字符长度最大值为新的无重复字符的最长子串
        
        var i = 0
        var j = 0
        var cache:[Character: Int] = [:]
        
        while j < count {
            let cur = characters[j]
            if let cacheJ = cache[cur] {
                i = max(i, cacheJ)
            }
            j += 1
            maxNum = max(maxNum, j-i)
            cache[cur] = j
        }
        return maxNum
    }
    
    
    @objc public static func defangIPaddr(_ address: String) -> String {
        let arr = address.components(separatedBy: ".")
        return arr.joined(separator: "[.]")
        
    }
    @objc public static func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var list1 = [Int]()
        var l1 = l1
        var l2 = l2
        
        while l1 != nil {
            list1.append(l1!.val)
            l1 = l1?.next
        }
        
        var list2 = [Int]()
        while l2 != nil {
            list2.append(l2!.val)
            l2 = l2?.next
        }
        
        var minCount = 0
        var list3 = [Int]()
        
        if list1.count > list2.count {
            list3 = list1
            minCount = list2.count
        } else {
            list3 = list2
            minCount = list1.count
        }
        
        if list3.count == 0 {
            return nil
        }
        
        var more: Int = 0
        
        let l3: ListNode? = ListNode(list3[0])
        var current = l3
        
        if minCount == 0 {
            for i in 0..<list3.count {
                current?.val = list3[i]
                let newNode = ListNode(0)
                current?.next = newNode
                current = newNode
            }
            return l3
        }
        
        let forCount = minCount
        for i in 0..<forCount {
            let result = list1[i] + list2[i] + more
            list3[i] = result % 10
            
            more = result / 10
            let newNode = ListNode(list3[i])
            current?.next = newNode
            current = newNode
        }
        
        var newCount = minCount
        let maxCount = list3.count
        while newCount < maxCount {
            let result = list3[newCount] + more
            list3[newCount] = result % 10
            
            more = result / 10
            newCount += 1
        }
        
        if more > 0 {
            list3.append(more)
            newCount += 1
        }
        
        for i in minCount..<newCount {
            let newNode = ListNode(list3[i])
            current?.next = newNode
            current = newNode
        }
        
        return l3?.next
    }
    
//
    
    @objc public static func eeeaddTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result: ListNode? = ListNode(0)
        
        var more: Int = 0
        var p = l1
        var q = l2
        var current = result
        
        while p != nil || q != nil {
            let sum = (p?.val ?? 0) + (q?.val ?? 0) + more
            more = sum / 10
            current?.next = ListNode(sum % 10)
            current = current?.next
            p = p?.next
            q = q?.next
        }
        
        if more > 0 {
            current?.next = ListNode(more)
        }
        
        return result?.next
    }
    
    @objc public static func eeeeeaddTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let result: ListNode? = ListNode(0)
        
        var more: Int = 0
        var p = l1
        var q = l2
        var current = result
        
        while p != nil || q != nil {
            let sum = (p?.val ?? 0) + (q?.val ?? 0) + more
            more = sum / 10
            current?.next = ListNode(sum % 10)
            current = current?.next
            p = p?.next
            q = q?.next
        }
        
        if more > 0 {
            current?.next = ListNode(more)
        }
        
        return result?.next
    }
}
