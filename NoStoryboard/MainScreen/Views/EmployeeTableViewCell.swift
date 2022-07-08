//
//  EmployeeCell.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.05.2022.
//

import UIKit
import Rswift

class EmployeeTableViewCell: UITableViewCell
{
    
    var shouldShowBirthday = false
    
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
        view.textColor = UIColor(red: 0.02, green: 0.02, blue: 0.063, alpha: 1)
        view.font = R.font.interMedium(size: 16)
        return view
    }()
    
    private let tagLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.591, green: 0.591, blue: 0.609, alpha: 1)
        view.font = R.font.interMedium(size: 14)
        return view
    }()
    
    private let departmentLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        view.font = R.font.interRegular(size: 13)
        return view
    }()
    
    let birthdayLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.361, alpha: 1)
        view.font = R.font.interRegular(size: 15)
        view.isHidden = true
        return view
    }()
    
    //  MARK: LOADING VIEWS
    
    private let nameLoadingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 144, height: 16)
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    
    private let departmentLoadingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 12)
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    
    private let imageLoadingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        view.layer.cornerRadius = 36
        view.backgroundColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
        return view
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(employeeImageView)
        addSubview(nameLabel)
        addSubview(tagLabel)
        addSubview(departmentLabel)
        addSubview(birthdayLabel)
        
        addSubview(imageLoadingView)
        addSubview(nameLoadingView)
        addSubview(departmentLoadingView)
        
        setupConstraints()
        
        setLoadingViewsConstraints()
        
        shimmerLoadingAnimation(viewToAnimate: imageLoadingView)
        shimmerLoadingAnimation(viewToAnimate: nameLoadingView)
        shimmerLoadingAnimation(viewToAnimate: departmentLoadingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBirthdayLabelVisibility(shouldShowBirthday: Bool) {
        birthdayLabel.isHidden = !shouldShowBirthday
    }
    
    private func setupConstraints(){
    
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
             employeeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10), employeeImageView.heightAnchor.constraint(equalToConstant: 72),
             employeeImageView.widthAnchor.constraint(equalToConstant: 72)
        ])
    
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        nameLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 16), nameLabel.centerYAnchor.constraint(equalTo: employeeImageView.centerYAnchor, constant: -20)
       ])
    
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4), tagLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            departmentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            departmentLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 20)
        ])
        
    
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            birthdayLabel.centerYAnchor.constraint(equalTo: employeeImageView.centerYAnchor, constant: -12),
            birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19.5)
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
            departmentLoadingView.widthAnchor.constraint(equalToConstant: 80),
            departmentLoadingView.heightAnchor.constraint(equalToConstant: 12)])
        
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
    
    func setData(firstName: String, lastName: String, tag: String, department: Department?, dateBirth: String){
        employeeImageView.image = UIImage(named: "goose")
        nameLabel.text = "\(firstName) \(lastName)"
        tagLabel.text = tag
        departmentLabel.text = department?.title
        birthdayLabel.text = dateBirth
    }
    
    private func shimmerLoadingAnimation(viewToAnimate: UIView){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.colors = [UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1).cgColor,
                                UIColor(red: 0.379, green: 0.949, blue: 0.581, alpha: 1).cgColor,
                                UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1).cgColor]
        
        gradientLayer.locations = [0, 0.5, 1]
        
        gradientLayer.frame = viewToAnimate.bounds
        

        viewToAnimate.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = Float.infinity
        animation.duration = 1

        gradientLayer.add(animation, forKey: animation.keyPath)
        
    }

}
