//
//  BottomSheetSortingView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.06.2022.
//

import UIKit
import Rswift

class BottomSheetSortingView: BaseView {
    
    private let radioButtonAlphabetSort = RadioButton(text: "По алфавиту")
    
    private let radioButtonbirthdaySort = RadioButton(text: "По дате рождения")

    override func setup() {
        
        addSubview(radioButtonbirthdaySort)
        addSubview(radioButtonAlphabetSort)
        
        setupConstraints()
        choseChecking()
        
    }
    
    func setupConstraints() {
        
        radioButtonAlphabetSort.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            radioButtonAlphabetSort.topAnchor.constraint(equalTo: topAnchor, constant: 84),
            radioButtonAlphabetSort.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
        
        radioButtonbirthdaySort.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            radioButtonbirthdaySort.topAnchor.constraint(equalTo: radioButtonAlphabetSort.bottomAnchor, constant: 40),
            radioButtonbirthdaySort.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        ])
        
    }
    
    func choseChecking(){

        if radioButtonbirthdaySort.isChecked {
            radioButtonAlphabetSort.isChecked = false
        } else {
            radioButtonAlphabetSort.isChecked = true
        }
        
    }

}
