//
//  BirthView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit
import Rswift

class BirthViewCell: BaseView {
    
    private let birthView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
        return view
    }()
    
    private let starImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.star()
        view.layer.borderWidth = 0
        return view
    }()
    
    private let birthDataLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.interMedium(size: 16)
        return label
    }()
    
    private let yearsLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.interMedium(size: 16)
        return label
    }()
    
    private let dividingLine: UIView = {
        let view = UIView(frame: CGRect(x: 16.0,
                                        y: 73.5,
                                        width: UIScreen.main.bounds.size.width - 32.0,
                                        height: 0.5))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(birthView)
        addSubview(starImageView)
        addSubview(birthDataLabel)
        addSubview(yearsLabel)
        addSubview(dividingLine)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupConstraints(){
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.centerYAnchor.constraint(equalTo: birthView.centerYAnchor).isActive = true
        starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        birthDataLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDataLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        birthDataLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 14).isActive = true
        
        yearsLabel.translatesAutoresizingMaskIntoConstraints = false
        yearsLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor).isActive = true
        yearsLabel.trailingAnchor.constraint(equalTo: birthView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    func setData(dateBirth: String, years: String){
        
        self.birthDataLabel.text = "\(dateBirth)"
        self.yearsLabel.text = "\(years)"
    }
}
