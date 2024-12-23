//
//  ViewController.swift
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//

import UIKit

func random(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
}

class RulersDealLevelGameViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var PencilOn = false
    @IBOutlet weak var sudokuView: RulersDealSudokuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PencilOn = false
       

    }

    @IBAction func pencilOn(_ sender: UIButton) {
        PencilOn.toggle()
        sender.isSelected = PencilOn
    }

    func refresh() {
        sudokuView.setNeedsDisplay()
    }

    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Simple(_ sender: Any) {
        let puzzle = appDelegate.sudoku
        puzzle.grid.gameDiff = "simple"
        performSegue(withIdentifier: "toPuzzle", sender: sender)
        let array = appDelegate.getPuzzles(puzzle.grid.gameDiff)
        puzzle.grid.plistPuzzle = puzzle.plistToPuzzle(plist: array[random(array.count)], toughness: puzzle.grid.gameDiff)
    }

    @IBAction func Hard(_ sender: Any) {
        let puzzle = appDelegate.sudoku
        puzzle.grid.gameDiff = "hard"
        performSegue(withIdentifier: "toPuzzle", sender: sender)
        let array = appDelegate.getPuzzles(puzzle.grid.gameDiff)
        puzzle.grid.plistPuzzle = puzzle.plistToPuzzle(plist: array[random(array.count)], toughness: puzzle.grid.gameDiff)
    }

    @IBAction func Continue(_ sender: Any) {
        let puzzle = appDelegate.sudoku
        let load = appDelegate.load
        print("\(String(puzzle.inProgress))")
        if puzzle.inProgress {
            performSegue(withIdentifier: "toPuzzle", sender: sender)
        } else if load != nil {
            appDelegate.sudoku.grid = load
            performSegue(withIdentifier: "toPuzzle", sender: sender)
        } else {
        let alert = UIAlertController(title: "Alert", message: "No Game in Progress & No Saved Games", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func leavePuzzle(_ sender: Any) {
        let alert = UIAlertController(title: "Leaving Current Game", message: "Are you sure you want to abandon?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let puzzle = self.appDelegate.sudoku
            puzzle.clearUserPuzzle()
            puzzle.clearPlistPuzzle()
            puzzle.clearPencilPuzzle()
            puzzle.gameInProgress(set: false)
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: true)
    }

    @IBOutlet weak var PuzzleArea: RulersDealSudokuView!

    @IBAction func Keypad(_ sender: UIButton) {
        let puzzle = appDelegate.sudoku
        puzzle.gameInProgress(set: true)
        var grid = puzzle.grid
        let row = PuzzleArea.selected.row
        let col = PuzzleArea.selected.column
        if row != -1 && col != -1 {
            if !PencilOn {
                if grid?.plistPuzzle[row][col] == 0 && grid?.userPuzzle[row][col] == 0 {
                    puzzle.userGrid(n: sender.tag, row: row, col: col)
                    refresh()
                } else if grid?.plistPuzzle[row][col] == 0 || grid?.userPuzzle[row][col] == sender.tag {
                    puzzle.userGrid(n: 0, row: row, col: col)
                    refresh()
                }
            } else {
                puzzle.pencilGrid(n: sender.tag, row: row, col: col)
                refresh()
            }
        }
    }

    @IBAction func MenuButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Menu", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Clear Conflicts", style: .default) { _ in
            let puzzle = self.appDelegate.sudoku
            puzzle.clearConflicts()
            self.refresh()
        })
        alert.addAction(UIAlertAction(title: "Clear All", style: .default) { _ in
            let puzzle = self.appDelegate.sudoku
            puzzle.clearUserPuzzle()
            puzzle.clearPencilPuzzle()
            puzzle.gameInProgress(set: false)
            self.refresh()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: true)
    }

    @IBAction func clearCell(_ sender: UIButton) {
        let row = PuzzleArea.selected.row
        let col = PuzzleArea.selected.column
        var grid = appDelegate.sudoku.grid
        if grid?.userPuzzle[row][col] != 0 {
            appDelegate.sudoku.userGrid(n: 0, row: row, col: col)
        }
        for i in 0...9 {
            appDelegate.sudoku.pencilGridBlank(n: i, row: row, col: col)
        }
        refresh()
    }
}

