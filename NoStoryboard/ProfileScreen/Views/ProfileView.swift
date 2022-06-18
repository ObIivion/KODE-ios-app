//
//  ProfileView.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 14.06.2022.
//

import UIKit


class ProfileView: BaseView {
    
    private let upView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.7))
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        return view
    }()
        
    private let employeeImageView: UIImageView = {
            let view = UIImageView()
            
            view.clipsToBounds = false
            view.image = UIImage(named: "goose")
            
            view.layer.shadowColor = CGColor(red: 22/255, green: 30/255, blue: 52/255, alpha : 0.08)
            view.layer.shadowOffset = CGSize(width: 0, height: 8)
            view.layer.shadowRadius = 12
            view.layer.shadowOpacity = 1
            
            return view
        }()
        
     let nameLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.font = UIFont(name: "Gill Sans SemiBold" , size: 24)
            view.textColor = UIColor(red: 0.05, green: 0.05, blue: 0.16, alpha: 1)
            view.text = "Алиса Иванова"
            return view
        }()
        
     let tagLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.font = UIFont(name: "Gill Sans SemiBold" , size: 14)
            view.textColor = UIColor(red: 0.151, green: 0.151, blue: 0.155, alpha: 1.0)
            view.text = "al"
            return view
        }()
        
     let departmentLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.font = UIFont(name: "Gill Sans Regular", size: 13)
            view.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.92, alpha: 1.0)
            view.text = "Designer"
            return view
        }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 73.5
        return view
    }()
    
    private let avatarResizer = ImageResizer()
    
     let birthCell = BirthViewCell()
     let phoneCell = PhoneViewCell()

        override func setup() {
            
        employeeImageView.image = avatarResizer.resizeImage(image: employeeImageView.image!, targetSize: CGSize(width: 104, height: 104))
        
        backgroundColor = .white
        
        stackView.addArrangedSubview(birthCell)
        stackView.addArrangedSubview(phoneCell)
            
        addSubview(stackView)
        addSubview(upView)
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
            
        setupImageViewConstraints()
        setupNameLabelConstraints()
        setupTagLabelConstraints()
        setupDepartmentLabelConstraints()
        setupStackViewConstraints()
            
        }
    
    func setupImageViewConstraints(){

        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        employeeImageView.topAnchor.constraint(equalTo: upView.topAnchor, constant: 104).isActive = true
        employeeImageView.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        
    }
    
    func setupNameLabelConstraints(){
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: employeeImageView.bottomAnchor, constant: 24).isActive = true
        
    }
    
    func setupTagLabelConstraints(){
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        
    }
    
    func setupDepartmentLabelConstraints(){
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.centerXAnchor.constraint(equalTo: upView.centerXAnchor).isActive = true
        departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
    }
    
    func setupStackViewConstraints(){
        
        stackView.topAnchor.constraint(equalTo: upView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    // лучше прокидывать  optional вместо forcce unwrap
    func setData(firstName: String, lastName: String, tag: String, department: Department?, phone: String, dateBirth: String, years: String){
        
        self.nameLabel.text = "\(firstName) \(lastName)"
        self.tagLabel.text = tag
        self.departmentLabel.text = department?.title
        phoneCell.setData(phoneNumber: phone)
        birthCell.setData(dateBirth: dateBirth, years: years)
        
    }
    
}
