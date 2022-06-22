//
//  RadioButton.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.06.2022.
//

import UIKit
import Rswift

class RadioButton: UIButton {
    
    private let radioText = UILabel()
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setBackgroundImage(R.image.isChecked(), for: .normal)
            } else {
                self.setBackgroundImage(R.image.unChecked(), for: .normal)
            }
        }
    }

    init(text: String) {
        super.init(frame: .zero)
        clipsToBounds = true
        addSubview(radioText)
        self.radioText.text = text
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        
        radioText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioText.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 14),
            radioText.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}


