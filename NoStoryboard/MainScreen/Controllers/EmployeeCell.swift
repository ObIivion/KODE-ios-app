//
//  EmployeeCell.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.05.2022.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    private let employeeImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.borderWidth = 0
        return view
    }()
    
    private let nameLabel: UILabel = {
        
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Gill Sans SemiBold" , size: 16)
        view.textColor = UIColor(red: 0.05, green: 0.05, blue: 0.16, alpha: 1)
        return view
    }()
    
    private let tagLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Gill Sans SemiBold" , size: 14)
        view.textColor = UIColor(red: 0.151, green: 0.151, blue: 0.155, alpha: 1.0)
        return view
    }()
    
    private let departmentLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont(name: "Gill Sans Regular", size: 13)
        view.textColor = UIColor(red: 0.85, green: 0.85, blue: 0.92, alpha: 1.0)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
        
        setImageViewConstraints()
        setNameLabelConstraints()
        setDepartmentLabelConstraints()
        setTagLabelConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageViewConstraints(){
        
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        employeeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        employeeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        employeeImageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        employeeImageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
    }
    
   func setNameLabelConstraints(){
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: employeeImageView.centerYAnchor, constant: -20).isActive = true
    }
    
    
    func setTagLabelConstraints(){
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }
    
    func setDepartmentLabelConstraints(){
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 20).isActive = true
    }
    
    func set(employee: Employee){
        
        employeeImageView.image = employee.image
        nameLabel.text = employee.name
        tagLabel.text = employee.tag
        departmentLabel.text = employee.department
        
    }
    
}
