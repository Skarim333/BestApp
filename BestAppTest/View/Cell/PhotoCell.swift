//
//  PhotoCell.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "PhotoCell"
    
    private var skeletonLayerName: String {
        return "skeletonLayerName"
    }
    
    private var skeletonGradientName: String {
        return "skeletonGradientName"
    }
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showSkeleton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        contentView.addSubview(photoImageView)
        makeConstraints()
        showSkeleton()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photoImageView.rightAnchor.constraint(equalTo: rightAnchor),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor),
            
        ])
    }
    
    func fill(with imageUrlString: URL) {
//        guard let url = URL(string: imageUrlString) else { return }
        photoImageView.kf.setImage(
            with: imageUrlString,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ],
            completionHandler: { _ in
                self.hideSkeleton()
            }
        )
    }
    
    // MARK: - Skeleton
    
    private func showSkeleton() {
        let backgroundColor = UIColor.systemGray.cgColor
        
        let highlightColor = UIColor.white.cgColor
        
        let skeletonLayer = CALayer()
        skeletonLayer.backgroundColor = backgroundColor
        skeletonLayer.name = skeletonLayerName
        skeletonLayer.anchorPoint = .zero
        skeletonLayer.frame.size = UIScreen.main.bounds.size
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [backgroundColor, highlightColor, backgroundColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.name = skeletonGradientName
        
        photoImageView.layer.mask = skeletonLayer
        photoImageView.layer.addSublayer(skeletonLayer)
        photoImageView.layer.addSublayer(gradientLayer)
        photoImageView.clipsToBounds = true
        let widht = UIScreen.main.bounds.width
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.fromValue = -widht
        animation.toValue = widht
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        gradientLayer.add(animation, forKey: "gradientLayerShimmerAnimation")
    }
    
    private func hideSkeleton() {
        photoImageView.layer.sublayers?.removeAll {
            $0.name == skeletonLayerName || $0.name == skeletonGradientName
        }
    }
    
}
