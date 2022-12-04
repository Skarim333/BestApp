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
//        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        showSkeleton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height - 28)
        titleLabel.frame = CGRect(x: 0, y: self.height-28, width: self.width, height: 14)
        dateLabel.frame = CGRect(x: 0, y: self.height-14, width: self.width, height: 14)
    }
    
    func fill(with model: Item) {
        photoImageView.kf.setImage(
            with: model.media.m,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ],
            completionHandler: { [weak self] _ in
                
                self?.hideSkeleton()
            }
        )
        titleLabel.text = model.title
        dateLabel.text = model.published.toDate()?.toString()
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
        
        contentView.layer.mask = skeletonLayer
        contentView.layer.addSublayer(skeletonLayer)
        contentView.layer.addSublayer(gradientLayer)
        contentView.clipsToBounds = true
        
        
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
        contentView.layer.sublayers?.removeAll {
            $0.name == skeletonLayerName || $0.name == skeletonGradientName
        }
    }
    
}
