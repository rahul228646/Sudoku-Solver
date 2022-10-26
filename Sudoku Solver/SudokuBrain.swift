//
//  SudokuBrain.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 26/10/22.
//

import Foundation

class SudokuBrain {
    internal typealias Char = Character
    func solveSudoku(_ board: inout [[Char]]) {
        guard board.count != 0 || board[0].count != 0 else { return }
        helper(&board)
    }
    
    private func helper(_ board: inout [[Char]]) -> Bool {
        for r in 0..<board.count {
            for c in 0..<board[0].count where board[r][c] == "." {
                for n in 1...9 where isValid(board, Char("\(n)"), r, c) {
                    board[r][c] = Char("\(n)")
                    if helper(&board) {
                        return true
                    } else {
                        board[r][c] = "."
                    }
                }
                return false
            }
        }
        return true
    }
    
    // Special thanks to @punk9595 for the optimization suggestion
    private func isValid(_ board: [[Char]], _ ch: Char, _ r: Int,  _ c: Int) -> Bool {
        for i in 0...8 {
            if board[r][i] == ch || board[i][c] == ch { return false }
            if board[(r / 3) * 3 + i / 3][(c / 3) * 3 + i % 3] == ch { return false }
        }
        return true
    }
}




