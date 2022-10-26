//
//  ViewController.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 25/10/22.
//

import UIKit

class GridViewController: UIViewController {
    
    let sudokuModel = SudokuModel()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Sudoku Solver"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GridCollectionViewCell.self , forCellWithReuseIdentifier: GridCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = UIColor.label.cgColor
        return collectionView
        
    }()
    
    private let solveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Solve", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(solveButton)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        solveButton.addTarget(self, action: #selector(solveAction), for: .touchUpInside)
        configLayout()
    }
    
    @objc func solveAction() {
        sudokuModel.solve()
        let board = sudokuModel.getBoard()
        let boardColor = sudokuModel.getColors()
        let nextViewController = ResultViewController()
        nextViewController.configResult(board: board, boardColor: boardColor)
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    func configLayout() {
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height*0.6),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width*0.9),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            
            solveButton.heightAnchor.constraint(equalToConstant: 50),
            solveButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            solveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.05),
            solveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width*0.05)),
            
        ])
    }
    

}

extension GridViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width*0.9))/9, height: ((view.frame.height*0.6))/9)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifier, for: indexPath) as? GridCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        cell.index(position: indexPath.row)
        cell.delegate = self
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
}

extension GridViewController : GridCollectionViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: GridCollectionViewCell, input: String?, pos : Int) {
      
        var val = input ?? "."
        if(val == "") {
            val = "."
        }
        sudokuModel.editBoard(row: pos/9, col: pos%9, val: Character(val))
    }
    
    
}


