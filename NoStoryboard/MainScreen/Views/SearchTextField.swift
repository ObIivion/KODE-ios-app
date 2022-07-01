//
//  SearchTextField.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 05.06.2022.
//

import UIKit
import Foundation
import Rswift

class SearchTextField: UITextField {
    
    public let rightImageButton = UIButton(frame: CGRect(x: -13.5, y: 0, width: 20, height: 20))
    
    private var insets: UIEdgeInsets
    
    
    init(inset: UIEdgeInsets){
        self.insets = inset
        super.init(frame: .zero)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let leftImage = UIImageView(frame: CGRect(x: 14, y: 0, width: 20, height: 20))
        leftImage.image = UIImage(named: "Vector")
        leftView.addSubview(leftImage)
        self.leftViewMode = .always
        self.leftView = leftView
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        rightImageButton.setBackgroundImage(R.image.listUiAlt(), for: .normal)
        
        rightView.addSubview(rightImageButton)
        self.rightViewMode = .always
        self.rightView = rightView
        
        self.layer.backgroundColor = CGColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 0
        self.placeholder = "Введите имя, тег, почту.."
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 30))
    }
    
}
