//
//  Models.swift
//  ios-showcase-scrollcollection
//
//  Created by Jingjing Zhu on 2018-09-20.
//  Copyright © 2018 pdftron-showcase. All rights reserved.
//

import UIKit

class FeatureCategory: NSObject {
    var name: String?
    var features: [Feature]?
    var type: String?
    
    static func fetchCategoryFeatures() {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) -> Void in
        
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                
                var featureCategories = [FeatureCategory]()
                for dict in json!["categories"] as! [[String: Any]] {
                    let featureCategory = FeatureCategory()
                    featureCategory.setValuesForKeys(dict)
                    featureCategories.append(featureCategory)
                }
                
            } catch let err {
                print(err)
            }
            
            
        }.resume()
        
    }
    
    
    static func sampleFeatureCategories() -> [FeatureCategory] {
        
        // for viewing Category
        let viewingCategory = FeatureCategory()
        viewingCategory.name = "PDF Basic Viewer"
        var viewingCategory_features = [Feature]()
        // logic
        let basicViewerFeature = Feature()
        basicViewerFeature.name = "Basic PDF Viewer"
        basicViewerFeature.category = "viewingCategory"
        basicViewerFeature.imageName = "image1"
        basicViewerFeature.price = NSNumber(floatLiteral: 3.99)
        viewingCategory_features.append(basicViewerFeature)
        
        viewingCategory.features = viewingCategory_features
        
        
        
        
        
        // for annotation Category
        let annotationCategory = FeatureCategory()
        annotationCategory.name = "Annotation"
        var annotationCategory_features = [Feature]()
        // logic
        let annotationToolbarFeature = Feature()
        annotationToolbarFeature.name = "Annotation Toolbar"
        annotationToolbarFeature.category = "annotationCategory"
        annotationToolbarFeature.imageName = "image2"
        annotationToolbarFeature.price = NSNumber(floatLiteral: 3.99)
        annotationCategory_features.append(annotationToolbarFeature)
        
        annotationCategory.features = annotationCategory_features
        
        return [viewingCategory, annotationCategory]
    }
}

class Feature: NSObject {
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}
