//
//  PhoneView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit
import Rswift

class PhoneViewCell: BaseView {
    
    private let phoneView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 73.5))
        return view
    }()
    
    private let phoneImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.phone()
        view.layer.borderWidth = 0
        return view
    }()
    
   private let phoneLabel: UILabel = {
       let label = UILabel()
       label.font = R.font.interMedium(size: 16)
       return label
    }()
    
    override func setup() {
        
        addSubview(phoneView)
        addSubview(phoneImageView)
        addSubview(phoneLabel)
        
        setPhoneImageConstraints()
        setPhoneLabelConstraints()
    }
    
   private func setPhoneImageConstraints(){
    
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor).isActive = true
        phoneImageView.leadingAnchor.constraint(equalTo: phoneView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setPhoneLabelConstraints(){
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 14).isActive = true
        phoneLabel.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor).isActive = true
    }

    func setData(phoneNumber: String) {
        self.phoneLabel.text = phoneNumber
    }
 
}
