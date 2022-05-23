//
//  UIView+Ext.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import Foundation
import UIKit

extension UIView {

    func pin(superView: UIView){
        translatesAutoresizingMaskIntoConstraints                              = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive            = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive      = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive    = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive  = true
    }
}
