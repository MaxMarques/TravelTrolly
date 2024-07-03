//
//  hueColorDetection.swift
//  TravelTrolley
//
//  Created by Marques on 4/26/24.
//

import SwiftUI

class hueColorDetection {
    func background(locationColor: UIColor, needWhiteColor: [UIColor]) -> Color {
        for color in needWhiteColor {
            if locationColor == color {
                return Color("background-3")
            }
        }
        return Color("background-2")
    }
}
