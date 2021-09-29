//
//  ColorHelper.swift
//  Pandemify
//
//  Created by Anda Tilea on 06.08.2021.
//

import UIKit

// custom colors for the UI components
class ColorHelper {
    // the color for the cell and the table (in Latest Data and Country List screens)
    func determineColorCellAndTable(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // beige color
            return UIColor.init(red: 0.56, green: 0.4, blue: 0.28, alpha: 0.5)
        } else {
            // light gray
            return UIColor.systemGray6.withAlphaComponent(0.5)
        }
    }
    // the color for the subtitle in the table view cell (in Latest Data screen)
    func determineColorDetail(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // white color
            return UIColor.white
        } else {
            // chestnut color
            return UIColor.init(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
        }
    }
    // the color for the title (in Country List screen)
    func determineColorTitle(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // light gray color
            return UIColor.systemGray6
        } else {
            // black color
            return UIColor.black
        }
    }
    // color of section index and search bar (in Country List screen)
    func determineColorSectionAndSearchBar(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // white color with a transparent effect
            return UIColor.white.withAlphaComponent(0.5)
        } else {
            // light gray with a transparent effect
            return  UIColor.systemGray6.withAlphaComponent(0.5)
        }
    }
    // text color fo the section index (in Country List screen)
    func determineColorTextSectionIndex(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // cooper color
            return UIColor.init(red: 0.6, green: 0.3176, blue: 0, alpha: 1.0)
        } else {
            // rusty brown color
            return UIColor.init(red: 0.5176, green: 0.2745, blue: 0.1804, alpha: 1.0)
        }
    }
    // tint color for the search bar (in Country List screen)
    func determineTintColor(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // light beige color
            return UIColor.init(red: 0.5882, green: 0.4118, blue: 0.2118, alpha: 0.4)
        } else {
            // dusty peach color
            return UIColor.init(red: 0.9373, green: 0.8588, blue: 0.7686, alpha: 1.0)
        }
    }
    // color for the section header (Country List Screen)
    func determineColorHeaderTitle(darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // white color with a transparent effect
            return UIColor.white.withAlphaComponent(0.5)
        } else {
            // light beige color
            return UIColor.init(red: 0.5882, green: 0.4118, blue: 0.2118, alpha: 0.4)
        }
    }
    // color for the cells in the Country Detail Screen
    func determineCellColor(perLevel: CGFloat, row: Int, darkModeSwitch: Bool) -> UIColor {
        if darkModeSwitch == true {
            // beige color with gradient effect
            return UIColor.init(red: 0.56, green: 0.4, blue: 0.28, alpha: 0.65)
        } else {
            // light beige with gradient effect
            return UIColor.init(red: 0.9373, green: 0.8588, blue: 0.7686,
                                alpha: (perLevel + CGFloat(row) * perLevel))
        }
    }
}
