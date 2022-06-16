//
//  DetailsVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit


class DetailsVC: BaseViewController<ProfileView> {
    
    var modelController = ModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondViewController"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.setData(firstName: modelController.employeeModel.firstName,
                         lastName: modelController.employeeModel.lastName,
                         tag: modelController.employeeModel.userTag,
                         department: modelController.employeeModel.department!,
                         phone: modelController.employeeModel.phone,
                         dateBirth: modelController.employeeModel.birthday,
                         years: 228)
        
    }
    
}
