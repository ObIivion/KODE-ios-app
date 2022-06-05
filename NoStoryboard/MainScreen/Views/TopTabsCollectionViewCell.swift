//
//  TopTabsCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 05.06.2022.
//

import UIKit

class TopTabsCollectionViewCell: UICollectionViewCell {
        
        static let identifier = "Cell"
        let label = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            label.textColor = .black
            contentView.addSubview(label)
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
        }
        
    }
