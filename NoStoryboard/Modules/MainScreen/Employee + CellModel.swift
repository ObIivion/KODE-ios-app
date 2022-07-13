//
//  Employee + CellModel.swift
//  NoStoryboard
//
//  Created by Кирилл on 13.07.2022.
//

import Foundation

extension EmployeeModel {
    var listCellModel: EmployeeTableViewCellModel {
        .init(name: "\(firstName) \(lastName)",
              tag: userTag,
              department: department?.title,
              dateBirth: birthdayDate.map(DateFormatter.employeeListBithdayFormatter.string) ?? "Дата не была получена")
    }
}

extension DateFormatter {
    static let employeeListBithdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd M"
        
        return formatter
    }()
}
