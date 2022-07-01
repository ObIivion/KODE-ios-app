import Foundation

struct EmployeeModel: Codable{
    
    let id: String
    let avatarURL: String?
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department?
    let position: String
    let birthday: String
    var birthdayDate: Date? {
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.locale = Locale(identifier: "ru_RU")
        dateFormatterSet.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        dateFormatterSet.dateFormat = "dd MMMM yyyy"
        
        let date = dateFormatterSet.date(from: birthday)
        return date
}
    let phone: String
}

struct EmployeeList: Codable {
    let items: [EmployeeModel]
}
