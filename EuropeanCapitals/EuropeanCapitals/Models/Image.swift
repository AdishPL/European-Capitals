//
//  Image.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 18/08/2020.
//

import UIKit

struct Image: Codable {
    let imageData: Data
    
    var image: UIImage {
        return UIImage(data: imageData) ?? UIImage()
    }
}
