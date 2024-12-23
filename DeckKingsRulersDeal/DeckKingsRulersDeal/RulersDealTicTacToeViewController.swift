//
//  TicTacToeVC.swift
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//


import UIKit

class RulersDealTicTacToeViewController: UIViewController {
    
    // Outlets
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    
    // Variables
    var board: [String] = Array(repeating: "", count: 9)
    var currentPlayer = "X"
    let xImage = UIImage(named: "x_image")
    let oImage = UIImage(named: "o_image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    


    
    // Action for button taps
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender), board[buttonIndex] == "" else {
            return // Ignore if already marked
        }
        
        // Update the board and button image
        board[buttonIndex] = currentPlayer
        sender.setImage(currentPlayer == "X" ? xImage : oImage, for: .normal)
        
        // Check for win or switch players
        if checkWin(for: currentPlayer) {
            statusLabel.text = "\(currentPlayer) Wins!"
            disableAllButtons()
        } else if board.allSatisfy({ !$0.isEmpty }) {
            statusLabel.text = "It's a Draw!"
        } else {
            currentPlayer = (currentPlayer == "X") ? "O" : "X"
            statusLabel.text = "\(currentPlayer)'s Turn"
        }
    }
    
    // Reset Game
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resetGame()
    }
    
    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        statusLabel.text = "X's Turn"
        for button in buttons {
            button.setImage(nil, for: .normal)
            button.isEnabled = true
        }
    }
    
    private func disableAllButtons() {
        for button in buttons {
            button.isEnabled = false
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func checkWin(for player: String) -> Bool {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6]             // Diagonals
        ]
        
        return winningCombinations.contains { combination in
            combination.allSatisfy { board[$0] == player }
        }
    }
}
