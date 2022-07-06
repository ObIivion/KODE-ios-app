//
//  HeaderSectionView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 05.07.2022.
//

import UIKit

class HeaderSectionView: BaseView {
    
    private let yearLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Gill Sans SemiBold" , size: 15)
        view.textColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        view.text = "2022"
        return view
    }()
    
    private let rightLine: UIView = {
        let view = UIView(frame: CGRect(x: UIScreen.main.bounds.width - UIScreen.main.bounds.width * 0.1915 - 24,
                                        y: 34,
                                        width: UIScreen.main.bounds.width * 0.1915,
                                        height: 3))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    private let leftLine: UIView = {
        let view = UIView(frame: CGRect(x: 24,
                                        y: 34,
                                        width: UIScreen.main.bounds.width * 0.1915,
                                        height: 3))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
    
    override func setup() {
        
        addSubview(yearLabel)
        addSubview(rightLine)
        addSubview(leftLine)
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            yearLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])  
    }
}
