//
//  AppStyling.swift
//  EuropeanCapitals
//
//  Created by Adrian Kaczmarek on 11/08/2020.
//

import UIKit

class AppStyling {
    static let colorWhite = UIColor.white

    static let colorPrimary = UIColor(red: 239/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    static let colorDarkGray = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
    static let colorLightGray = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1.0)
    static let colorSeparator = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    
    static func fontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size)!
    }
}
