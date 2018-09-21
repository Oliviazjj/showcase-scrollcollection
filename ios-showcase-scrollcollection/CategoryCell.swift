//
//  CategoryCell.swift
//  ios-showcase-scrollcollection
//
//  Created by Jingjing Zhu on 2018-09-20.
//  Copyright © 2018 pdftron-showcase. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var ViewingIsExpanded = false
    var AnnotationIsExpanded = false
    
    var featureCategory: FeatureCategory? {
        didSet {
            
            if let name = featureCategory?.name {
                nameLabel.text = name
            }
            
            featureCollectionView.reloadData()
            
        }
    }
    
    private let cellId = "featureCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Basics"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let featureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("seeAll", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name:"Times New Roman", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(featureCollectionView) //add column subviews into rows
        addSubview(dividerLineView)
        addSubview(nameLabel)
        addSubview(seeAllButton)
        
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
        
        featureCollectionView.register(FeatureCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": seeAllButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": featureCollectionView])) //expand from left to right

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLable(30)][seeAllButton(20)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": featureCollectionView, "v1": dividerLineView, "nameLable": nameLabel, "seeAllButton": seeAllButton]))//expand from top to bottom
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = featureCategory?.features?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeatureCell
        cell.feature = featureCategory?.features?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
}


class FeatureCell: UICollectionViewCell {
    
    var feature: Feature? {
        didSet {
            if let name = feature?.Name {
                nameLabel.text = name
            }
            
            CategoryLabel.text = feature?.Category
            
            if let description = feature?.Description {
                descriptionLabel.text = description
            } else {
                descriptionLabel.text = ""
            }
            if let imageName = feature?.ImageName {
                imageView.image = UIImage(named: imageName)
			} else {
				imageView.image = UIImage(named: "noImage")
			}
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "feature: Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let CategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Basic"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "feature description"
        label.font = UIFont.systemFont(ofSize: 13)
		label.numberOfLines = 2
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(CategoryLabel)
        addSubview(descriptionLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        CategoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        descriptionLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 40)
    }
}




