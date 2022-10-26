//
//  GridCollectionViewCell.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 25/10/22.
//

import UIKit

protocol GridCollectionViewCellDelegate : AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell : GridCollectionViewCell, input : String? , pos : Int)
}


class GridCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    static let identifier = "GridCollectionViewCell"
    var idx : Int = 0
    weak var delegate: (GridCollectionViewCellDelegate)?
    
    private let sudokuInput : UITextField = {
        let sudokuInput = UITextField()
        sudokuInput.leftViewMode = .always
        sudokuInput.autocapitalizationType = .none
        sudokuInput.backgroundColor = .white
        sudokuInput.keyboardType = .numberPad
        sudokuInput.textColor = .red
        sudokuInput.font = .systemFont(ofSize: 24, weight: .light)

        return sudokuInput
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(sudokuInput)
        sudokuInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width/3.2, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        sudokuInput.frame = contentView.bounds
        sudokuInput.delegate = self

    }
    
    func index(position : Int) {
        idx = position
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            
            return false
        }
        
        //Limit the character count to 10.
        if ((textField.text!) + string).count > 10 {
            
            return false
        }
        
        //Only allow numbers. No Copy-Paste text values.
        let allowedCharacterSet = CharacterSet.init(charactersIn: "123456789")
        let textCharacterSet = CharacterSet.init(charactersIn: textField.text! + string)
        if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
            return false
        }
        return true
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            self.delegate?.collectionViewTableViewCellDidTapCell(self, input : text, pos: idx)
        }
    }
}


