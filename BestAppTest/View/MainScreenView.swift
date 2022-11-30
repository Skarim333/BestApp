//
//  MainScreenView.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import UIKit

class MainScreenView: UIView {
    
    lazy var photoCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flow
        )
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoCollectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
