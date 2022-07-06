//
//  BottomSheetSortingView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.06.2022.
//

import UIKit
import Rswift

class BottomSheetSortingView: BaseView {
    
    let alphabetSortRadioButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setBackgroundImage(R.image.unSelected(), for: .normal)
        button.setBackgroundImage(R.image.isSelected(), for: .selected)
        return button
    }()
    
    let birthdaySortRadioButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setBackgroundImage(R.image.unSelected(), for: .normal)
        button.setBackgroundImage(R.image.isSelected(), for: .selected)
        return button
     }()
    
    private let alphabetSortLabel: UILabel = {
        let label = UILabel()
        label.text = "По алфавиту"
        label.textColor = UIColor(cgColor: CGColor(red: 5/255, green: 5/255, blue: 16/255, alpha: 1))
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()
    
    private let birthdaySortLabel: UILabel = {
        let label = UILabel()
        label.text = "По дате рождения"
        label.textColor = UIColor(cgColor: CGColor(red: 5/255, green: 5/255, blue: 16/255, alpha: 1))
        label.font = UIFont(name: "Inter-Medium", size: 16)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сортировка"
        label.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        label.font = UIFont(name: "Inter-SemiBold", size: 20)
        return label
    }()
    
    override func setup() {
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(alphabetSortRadioButton)
        addSubview(birthdaySortRadioButton)
        addSubview(birthdaySortLabel)
        addSubview(alphabetSortLabel)
        
        setupConstraints()
        
    }
    
   private func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        alphabetSortRadioButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            alphabetSortRadioButton.topAnchor.constraint(equalTo: topAnchor, constant: 84),
            alphabetSortRadioButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
        ])
        
        birthdaySortRadioButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            birthdaySortRadioButton.topAnchor.constraint(equalTo: alphabetSortRadioButton.bottomAnchor, constant: 40),
            birthdaySortRadioButton.leadingAnchor.constraint(equalTo: alphabetSortRadioButton.leadingAnchor),
        ])
        
        alphabetSortLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            alphabetSortLabel.leadingAnchor.constraint(equalTo: alphabetSortRadioButton.trailingAnchor, constant: 14),
            alphabetSortLabel.centerYAnchor.constraint(equalTo: alphabetSortRadioButton.centerYAnchor)
            
        ])
        
        birthdaySortLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            birthdaySortLabel.leadingAnchor.constraint(equalTo: birthdaySortRadioButton.trailingAnchor, constant: 14),
            birthdaySortLabel.centerYAnchor.constraint(equalTo: birthdaySortRadioButton.centerYAnchor)
    
        ])
    }
}
