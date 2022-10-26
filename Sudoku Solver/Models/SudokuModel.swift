//
//  sudokuModel.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 26/10/22.
//

import Foundation

class SudokuModel {
    private var board = Array(repeating: Array(repeating: Character("."), count: 9), count: 9)
    
    func editBoard(row : Int, col : Int, val : Character) {
        board[row][col] = val
    }
    
    func solve() {
        let sudokuBrain = SudokuBrain()
        sudokuBrain.solveSudoku(&board)
    }
    
    func getBoard()->[[Character]]{
        return board
    }
}
