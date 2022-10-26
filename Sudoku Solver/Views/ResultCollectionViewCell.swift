//
//  ResultCollectionViewCell.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 26/10/22.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ResultCollectionViewCell"
    
    private let label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .light)
//        label.textColor = 
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
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
        
    }
    
}
