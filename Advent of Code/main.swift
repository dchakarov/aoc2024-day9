//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    let string = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }.first!
    let arr = Array(string)
    let line = arr.map { Int(String($0))! }
    
    var fileSystem = [Int]()
    var fileId = 0
    var emptyBlockIds: [Int] = []
    
    for i in 0..<line.count {
        if i.isMultiple(of: 2) {
            for _ in 0..<line[i] {
                fileSystem.append(fileId)
            }
            fileId += 1
        } else { // empty space
            for _ in 0..<line[i] {
                fileSystem.append(-1)
                emptyBlockIds.append(fileSystem.count - 1)
            }
        }
    }
    
    var currentIndex = fileSystem.count
    while currentIndex > 0 && !emptyBlockIds.isEmpty {
        currentIndex -= 1
        if fileSystem[currentIndex] != -1 {
            let emptyBlockId = emptyBlockIds.removeFirst()
            if emptyBlockId > currentIndex {
                break
            }
            fileSystem[emptyBlockId] = fileSystem[currentIndex]
            fileSystem[currentIndex] = -1
        }

    }
        
    var checksum = 0
    for i in 0..<fileSystem.count {
        if fileSystem[i] == -1 { break }
        checksum += fileSystem[i] * i
    }
    print(checksum)
}

main()
