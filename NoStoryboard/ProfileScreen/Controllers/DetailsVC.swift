//
//  DetailsVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 15.06.2022.
//

import UIKit
import Rswift

class DetailsVC: BaseViewController<ProfileView> {
    
    var employee: EmployeeModel! // force unwrap - зло. Но тут можно. Если ты гарантируешь что ты сначала установишь  значение, и только потом вызовется view did load

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SecondViewController"
        
        let formattedPhone = formatPhone(phone: employee.phone)
        let formattedBirthday = formatDate(date: employee.birthdayDate)
        let calculatedYears = calculateYears(date: employee.birthdayDate)
    
        // перенес во view did load  потому что нет смысла выносить во view did appear - можно один раз при загрузке контроллера
        mainView.setData(firstName: employee.firstName,
                         lastName: employee.lastName,
                         tag: employee.userTag,
                         department: employee.department,
                         phone: formattedPhone,
                         dateBirth: formattedBirthday,
                         years: calculatedYears)
    }
    
    func formatPhone(phone: String) -> String {
        
        var formattedPhone = "+7 (" + phone.filter { $0.isNumber }
        
        formattedPhone.insert(contentsOf: [")"," "], at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 7))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 12))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 15))
        
        return formattedPhone
    }
    
    func formatDate (date: Date?) -> String {

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")

        if let date = date {
            
            var date = formatter.string(from: date)
            date.removeLast(3)
            return date
        }
        
        return "Дата не была получена"
            
    }
    
    func calculateYears(date: Date?) -> String {
        
        if let date = date {

            let calendar = Calendar.current
            let dateCurrent = Date()

            if let years = calendar.dateComponents([.year], from: date, to: dateCurrent).year {

                let str = R.string.yearsDict.number_of_ages(ages: years)
            return str
            }
        }
        return "Не удалось вычислить год"
    }
}
