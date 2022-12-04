//
//  DetailViewController.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var url: URL?
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 1
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoImageView)
        photoImageView.kf.setImage(with: url)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.frame = view.bounds
    }

}
