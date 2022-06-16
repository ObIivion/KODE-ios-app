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
    let phone: String
}


struct EmployeeList: Codable {
    let items: [EmployeeModel]
}
