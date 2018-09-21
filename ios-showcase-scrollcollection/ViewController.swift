//
//  ViewController.swift
//  ios-showcase-scrollcollection
//
//  Created by Jingjing Zhu on 2018-09-20.
//  Copyright © 2018 pdftron-showcase. All rights reserved.
//

import UIKit

class FeatureViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
	
	var featuredApps: FeaturedApps?
    var featureCategories: [FeatureCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        featureCategories = FeatureCategory.sampleFeatureCategories()
		
		var featuredapp = FeatureCategory.fetchFeaturedApps()
		self.featuredApps = featuredapp
		self.featureCategories = featuredapp.categories
		
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.featureCategory = featureCategories?[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = featureCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 230)
    }
    
}
