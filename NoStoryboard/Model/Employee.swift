//
//  Employee.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 23.05.2022.
//

import Foundation
import UIKit

struct Employee {
    let image = UIImage(named: "goose")
    var name: String
    var tag: String
    var department: String
    
}

extension EmployeeListVC{

    func setDataEmployee() -> [Employee] {

        var listEmployee: [Employee] = []
        
        listEmployee.append(Employee(name: "Алексей Миногаров", tag: "mi", department: "Analyst"))
        listEmployee.append(Employee(name: "Алиса Иванова", tag: "al", department: "Designer"))
        listEmployee.append(Employee(name: "Андрей Иванов", tag: "iv", department: "Designer"))
        listEmployee.append(Employee(name: "Анна Иванова", tag: "an", department: "Analyst Team Lead"))

        return listEmployee
    }
    
}
