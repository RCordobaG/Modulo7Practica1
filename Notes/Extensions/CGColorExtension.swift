//
//  CGColorExtension.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation
import UIKit

public extension CGColor {
    var UIColor : UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
