//
//  EmployeeCell.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.05.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    static let identifier = "tableCell"

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
    
    //  MARK: LOADING VIEWS
    
    private let nameLoadingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    
    private let departmentLoadingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    
    private let imageLoadingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 50
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
        
        addSubview(imageLoadingView)
        addSubview(nameLoadingView)
        addSubview(departmentLoadingView)
        
        setImageViewConstraints()
        setNameLabelConstraints()
        setDepartmentLabelConstraints()
        setTagLabelConstraints()
        
        setLoadingViewsConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImageViewConstraints(){
        
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
             employeeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), employeeImageView.heightAnchor.constraint(equalToConstant: 72),
             employeeImageView.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    private func setNameLabelConstraints(){
       
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        nameLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 16), nameLabel.centerYAnchor.constraint(equalTo: employeeImageView.centerYAnchor, constant: -20)
       ])
    }
    
    private func setTagLabelConstraints(){
        
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4), tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
    
    private func setDepartmentLabelConstraints(){
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 20)
        ])
        
    }
    
    private func setLoadingViewsConstraints() {
        
        imageLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLoadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageLoadingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageLoadingView.heightAnchor.constraint(equalToConstant: 72),
            imageLoadingView.widthAnchor.constraint(equalToConstant: 72)])
        
        nameLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            nameLoadingView.leadingAnchor.constraint(equalTo: imageLoadingView.trailingAnchor, constant: 16),
            nameLoadingView.centerYAnchor.constraint(equalTo: imageLoadingView.centerYAnchor, constant: -20),
            nameLoadingView.widthAnchor.constraint(equalToConstant: 144),
            nameLoadingView.heightAnchor.constraint(equalToConstant: 16)])
        
        departmentLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            departmentLoadingView.leadingAnchor.constraint(equalTo: nameLoadingView.leadingAnchor),
            departmentLoadingView.centerYAnchor.constraint(equalTo: nameLoadingView.centerYAnchor, constant: 20),
            nameLoadingView.widthAnchor.constraint(equalToConstant: 80),
            nameLoadingView.heightAnchor.constraint(equalToConstant: 12)])
        
    }
    
    func setLoadingView() {
        
        nameLabel.isHidden = true
        employeeImageView.isHidden = true
        departmentLabel.isHidden = true
        tagLabel.isHidden = true
        departmentLabel.isHidden = true
        
        imageLoadingView.isHidden = false
        nameLoadingView.isHidden = false
        departmentLoadingView.isHidden = false
        
    }
    
    
    func setViewWithData() {
        
        nameLabel.isHidden = false
        employeeImageView.isHidden = false
        departmentLabel.isHidden = false
        tagLabel.isHidden = false
        departmentLabel.isHidden = false
        
        imageLoadingView.isHidden = true
        nameLoadingView.isHidden = true
        departmentLoadingView.isHidden = true
        
    }
    
    func set(employee: EmployeeModel){
        employeeImageView.image = UIImage(named: "goose")
        nameLabel.text = "\(employee.firstName) \(employee.lastName)"
        tagLabel.text = employee.userTag
        departmentLabel.text = employee.department?.title // поправил под номую модельку с енамом Department
    }

}
