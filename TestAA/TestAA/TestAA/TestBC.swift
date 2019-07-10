//
//  TestBC.swift
//  TestAA
//
//  Created by 程祥贺 on 2019/7/10.
//  Copyright © 2019 程祥贺. All rights reserved.
//

import UIKit

@objc public class TestBC: NSObject {
    private static let SIZE = 256; // 全局变量或成员变量
    
    @objc public static func test1() {
        let a:[Character] = ["c","a","b","c","a","b","a","c","a","c","a"]
        let b:[Character] = ["a","c","a","c","a"]

        let result = TestBC.bm(a: a, n: a.count, b: b, m: b.count)
        print("result:\(result)")
    }
    
    static func generateBC(b: [Character], m: Int, bc: inout [Int]) {
        for i in 0..<m {
            let ascii = Int(b[i].asciiValue ?? 0) // 计算 b[i] 的 ASCII 值
            bc[ascii] = i
        }
    }
    // b 表示模式串，m 表示长度，suffix，prefix 数组事先申请好了
    static func generateGS(b: [Character], m: Int, suffix: inout [Int], prefix: inout [Bool]) {
        for i in 0..<m-1 { // b[0, i]
            var j = i
            var k = 0 // 公共后缀子串长度
            print("i:\(i)  k:\(k)")
            while (j >= 0 && b[j] == b[m-1-k]) { // 与 b[0, m-1] 求公共后缀子串
                print("b[\(j)]:\(b[j]) == b[\(m-1-k)]:\(b[m-1-k])")
                j -= 1
                k += 1
                suffix[k] = j+1 //j+1 表示公共后缀子串在 b[0, i] 中的起始下标
                print("suffix[\(k)] = \(j+1)")
            }
            if (j == -1) {// 如果公共后缀子串也是模式串的前缀子串
                prefix[k] = true
            }
        }
    }
    
    // a,b 表示主串和模式串；n，m 表示主串和模式串的长度。
    public static func bm(a: [Character], n: Int, b: [Character], m: Int) -> Int {
        var bc = Array.init(repeating: -1, count: SIZE) // 记录模式串中每个字符最后出现的位置
        generateBC(b: b, m: m, bc: &bc) // 构建坏字符哈希表
        /*
        - 96 : -1
        - 97 : 2
        - 98 : 3
        - 99 : 1
        - 100 : 0
        - 101 : -1
        - 102 : -1
 */
        var suffix = Array.init(repeating: -1, count: m)
        var prefix = Array.init(repeating: false, count: m)
        generateGS(b: b, m: m, suffix: &suffix, prefix: &prefix)
        
        var i = 0; // j 表示主串与模式串匹配的第一个字符
        while (i <= n - m) {
            var j = 0
//            for idx in (-1...m-1).reversed() { // 模式串从后往前匹配
            for idx in stride(from: m - 1, through: 0, by: -1) { // 模式串从后往前匹配
                j = idx
                if (a[i+j] != b[j]) {// 坏字符对应模式串中的下标是 j
                    break
                }
                j -= 1
            }
            
            if (j < 0) {// 匹配成功，返回主串与模式串第一个匹配的字符的位置
                return i
            }
            
            let x = j - bc[Int(a[i+j].asciiValue ?? 0)]
            var y = 0;
            if (j < m-1) { // 如果有好后缀的话
                y = moveByGS(j: j, m: m, suffix: &suffix, prefix: &prefix)
            }
            i = i + max(x, y)
        }
        return -1
    }
    
    // j 表示坏字符对应的模式串中的字符下标 ; m 表示模式串长度， 返回移动的位置个数
    private static func moveByGS(j: Int, m: Int, suffix: inout [Int], prefix: inout [Bool]) -> Int {
        let k = m - 1 - j // 好后缀长度
        if suffix[k] != -1 {
            return j + 1 - suffix[k]
        }

        if j+2 < m-1 {
            for r in j+2...m-1 {//j表示坏字符的下标 好后缀其实下标j+1
                if (prefix[m-r] == true) {
                    return r
                }
            }
        }
       
        return m
    }
}
