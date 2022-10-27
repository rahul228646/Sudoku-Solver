//
//  ResultCollectionViewCell.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 26/10/22.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ResultCollectionViewCell"
    
    var idx : Int = 0
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
    }
    func position(idx : Int) {
        self.idx = idx
    }
    
    func config(val : String, color : String) {
        label.text = val
        label.textColor = (color == "red") ? .systemRed : .systemGreen
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        if idx >= 18 && idx <= 26 || idx >= 45 && idx <= 53 {
            addBottomBorder(with: .label, andWidth: 2)
        }
        
        if idx%3 == 0 {
            addLeftBorder(with: .label, andWidth: 2)
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
