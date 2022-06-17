//
//  DetailsVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit


class DetailsVC: BaseViewController<ProfileView> {
    
    var employee: EmployeeModel! // force unwrap - зло. Но тут можно. Если ты гарантируешь что ты сначала установишь  значение, и только потом вызовется view did load
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondViewController"
    
        // перенес во view did load  потому что нет смысла выносить во view did appear - можно один раз при загрузке контроллера
        mainView.setData(firstName: employee.firstName,
                         lastName: employee.lastName,
                         tag: employee.userTag,
                         department: employee.department,
                         phone: employee.phone,
                         dateBirth: employee.birthday,
                         years: 228)
        
        
    }
    
}
