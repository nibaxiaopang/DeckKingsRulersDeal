//
//  sudokuData.swift
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//


import UIKit

struct RulersDealSudokuData: Codable {
    var gameDiff: String = "simple"
    var plistPuzzle: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var pencilPuzzle: [[[Bool]]] = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: 10), count: 9), count: 9)
    var userPuzzle: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
}
