//
//  TopTabsCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 05.06.2022.
//

import UIKit

class TopTabsCollectionViewCell: UICollectionViewCell {
    
    private(set) var model: Department?
    
    static let identifier = "Cell"
    private let label = UILabel()
    private var bottomBorderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 2))
    
    func setCellSelected(_ isSelected: Bool) {
        if isSelected {
            bottomBorderView.isHidden = false
        } else {
            bottomBorderView.isHidden = true
        }
    }
    
    func setModel(_ department: Department) {
        self.model = department
        label.text = department.title
    }
            
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.textColor = .black
            bottomBorderView.backgroundColor = .blue
            bottomBorderView.isHidden = false
            contentView.addSubview(label)
            contentView.addSubview(bottomBorderView)
            layoutSubviews()
            
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.heightAnchor.constraint(equalToConstant: 36).isActive = true
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -16).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            
            bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            bottomBorderView.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
            bottomBorderView.trailingAnchor.constraint(equalTo: label.trailingAnchor).isActive = true
            bottomBorderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        }
    
    }
