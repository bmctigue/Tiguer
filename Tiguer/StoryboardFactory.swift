//
//  StoryboardFactory.swift
//  Tiguer
//
//  Created by Bruce McTigue on 11/30/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

struct StoryboardFactory: StoryboardFactoryProtocol {
    func create(name: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard
    }
}
