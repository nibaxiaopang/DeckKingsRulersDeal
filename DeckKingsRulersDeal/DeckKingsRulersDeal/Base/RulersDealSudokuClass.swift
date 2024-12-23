//
//  sudokuClass.swift
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//

import UIKit

class RulersDealSudokuClass {
    var inProgress = false
    var grid: RulersDealSudokuData! = RulersDealSudokuData()
    
    func numberAt(row: Int, column: Int) -> Int {
        if grid.plistPuzzle[row][column] != 0 {
            return grid.plistPuzzle[row][column]
        } else {
            return grid.userPuzzle[row][column]
        }
    }
    
    func numberIsFixedAt(row: Int, column: Int) -> Bool {
        return grid.plistPuzzle[row][column] != 0
    }
    
    func isConflictingEntryAt(row: Int, column: Int) -> Bool {
        let n = grid.plistPuzzle[row][column] == 0 ? grid.userPuzzle[row][column] : grid.plistPuzzle[row][column]
        if n == 0 { return false }
        for r in 0...8 {
            if r != row && (grid.plistPuzzle[r][column] == n || grid.userPuzzle[r][column] == n) {
                return true
            }
        }
        for c in 0...8 {
            if c != column && (grid.plistPuzzle[row][c] == n || grid.userPuzzle[row][c] == n) {
                return true
            }
        }
        let threeByThreeRow = row / 3
        let threeByThreeCol = column / 3
        let startRow = threeByThreeRow * 3
        let startCol = threeByThreeCol * 3
        for r in startRow...(startRow + 2) {
            for c in startCol...(startCol + 2) {
                if (r != row || c != column) && (grid.plistPuzzle[r][c] == n || grid.userPuzzle[r][c] == n) {
                    return true
                }
            }
        }
        return false
    }
    
    func anyPencilSetAt(row: Int, column: Int) -> Bool {
        for n in 0...8 {
            if grid.pencilPuzzle[row][column][n] {
                return true
            }
        }
        return false
    }
    
    func isSetPencil(n: Int, row: Int, column: Int) -> Bool {
        return grid.pencilPuzzle[row][column][n]
    }
    
    func plistToPuzzle(plist: String, toughness: String) -> [[Int]] {
        var puzzle = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
        let plistZeroed = plist.replacingOccurrences(of: ".", with: "0")
        var col = 0
        var row = 0
        for c in plistZeroed {
            puzzle[row][col] = Int(String(c))!
            row += 1
            if row == 9 {
                row = 0
                col += 1
                if col == 9 {
                    return puzzle
                }
            }
        }
        return puzzle
    }
    
    func userGrid(n: Int, row: Int, col: Int) {
        grid.userPuzzle[row][col] = n
    }
    
    func userEntry(row: Int, column: Int) -> Int {
        return grid.userPuzzle[row][column]
    }
    
    func pencilGrid(n: Int, row: Int, col: Int) {
        grid.pencilPuzzle[row][col][n] = !grid.pencilPuzzle[row][col][n]
    }
    
    func pencilGridBlank(n: Int, row: Int, col: Int) {
        grid.pencilPuzzle[row][col][n] = false
    }
    
    func clearPlistPuzzle() {
        grid.plistPuzzle = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    }
    
    func clearPencilPuzzle() {
        grid.pencilPuzzle = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: 10), count: 9), count: 9)
    }
    
    func clearUserPuzzle() {
        grid.userPuzzle = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    }
    
    func clearConflicts() {
        for r in 0...8 {
            for c in 0...8 {
                if isConflictingEntryAt(row: r, column: c) {
                    grid.userPuzzle[r][c] = 0
                }
            }
        }
    }
    
    func gameInProgress(set: Bool) {
        inProgress = set
    }
}
