//
//  HeaderSectionView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 05.07.2022.
//

import UIKit
import Rswift

class HeaderSectionView: BaseView {
    
    private let yearLabel: UILabel = {
        let view = UILabel()
        view.font = R.font.interSemiBold(size: 15)
        view.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        view.textAlignment = .center
        view.text = "2022"
        return view
    }()
    
    private let rightLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    private let leftLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    override func setup() {
        
        addSubview(yearLabel)
        addSubview(rightLine)
        addSubview(leftLine)
        
        backgroundColor = .darkGray
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leftLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            leftLine.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            leftLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLine.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        NSLayoutConstraint.activate([
            rightLine.centerYAnchor.constraint(equalTo: yearLabel.centerYAnchor),
            rightLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLine.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor),
            rightLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
