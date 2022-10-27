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
    
    let toolbar : UIToolbar = {
        let toolbar = UIToolbar()
        return toolbar
    }()
    

    private let sudokuInput : UITextField = {
        let sudokuInput = UITextField()
        sudokuInput.leftViewMode = .always
        sudokuInput.autocapitalizationType = .none
        sudokuInput.keyboardType = .numberPad
        sudokuInput.textColor = .red
        sudokuInput.font = .systemFont(ofSize: 24, weight: .light)
        return sudokuInput
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.addSubview(sudokuInput)
        sudokuInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width/3.2, height: 0))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        sudokuInput.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonTapped() {
        sudokuInput.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        sudokuInput.frame = contentView.bounds
        sudokuInput.delegate = self
        if idx >= 18 && idx <= 26 || idx >= 45 && idx <= 53 {
            addBottomBorder(with: .label, andWidth: 2)
        }
        
        if idx%3 == 0 {
            addLeftBorder(with: .label, andWidth: 2)
        }
        
    }
    
    func index(position : Int) {
        idx = position
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            
            return false
        }
        
        //Limit the character count to 10.
        if ((textField.text!) + string).count > 1 {
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
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }



}


