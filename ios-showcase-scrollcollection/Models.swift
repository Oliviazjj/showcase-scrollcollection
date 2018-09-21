//
//  Models.swift
//  ios-showcase-scrollcollection
//
//  Created by Jingjing Zhu on 2018-09-20.
//  Copyright © 2018 pdftron-showcase. All rights reserved.
//

import UIKit
import Foundation

struct FeaturedApps: Decodable {
	
	var bannerCategory: FeatureCategory?
	var categories: [FeatureCategory]?
	
}

struct FeatureCategory: Decodable {
    var name: String?
    var features: [Feature]?
    var type: String?
    
	static func fetchFeaturedApps() -> FeaturedApps {
		var featuredApps: FeaturedApps?
		if let path = Bundle.main.path(forResource: "featuresCategory", ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: path))
				featuredApps = try JSONDecoder().decode(FeaturedApps.self, from: data)
			} catch let error{
				print(error.localizedDescription)
			}
		}
		return featuredApps!
	}
}
	
struct Feature: Decodable {
	
	let Id: Int?
	var Name: String?
	var Category: String?
	var ImageName: String?
	var Description: String?

}


