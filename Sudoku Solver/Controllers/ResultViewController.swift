//
//  ResultViewController.swift
//  Sudoku Solver
//
//  Created by rahul kaushik on 26/10/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    private var board = [[Character]]()
    private var boardColor = [[String]]()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Result"
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
        
        collectionView.register(ResultCollectionViewCell.self , forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.layer.borderWidth = 2
        collectionView.layer.borderColor = UIColor.label.cgColor
        return collectionView
        
    }()
    
    private let ReCalulateButton : UIButton = {
        let button = UIButton()
        button.setTitle("Recalulate", for: .normal)
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
        view.addSubview(ReCalulateButton)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        ReCalulateButton.addTarget(self, action: #selector(recalculateAction), for: .touchUpInside)
        configLayout()
    }
    
    func configResult(board : [[Character]], boardColor : [[String]]) {
        self.board = board
        self.boardColor = boardColor
    }
    
    @objc func recalculateAction() {
        navigationController?.popViewController(animated: true)
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
            
            ReCalulateButton.heightAnchor.constraint(equalToConstant: 50),
            ReCalulateButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            ReCalulateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width*0.05),
            ReCalulateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width*0.05)),
            
        ])
    }
    

}

extension ResultViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width*0.9))/9, height: ((view.frame.height*0.6))/9)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        let row = indexPath.row/9
        let col = indexPath.row%9
        cell.config(val: String(board[row][col]), color : boardColor[row][col])
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 0.5
        
        return cell
    }
    
    
}
