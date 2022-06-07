//
//  EmployeeApi.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 24.05.2022.
//

import Foundation

struct EmployeeList: Codable {
    let items: [EmployeeModel]
}

struct EmployeeModel: Codable{
    let id: String
    let avatarURL: String?
    let firstName: String
    let lastName: String
    let userTag: String
    let department: String
    let position: String
    let birthday: String
}

class ApiProvider<Response: Codable> {

    func getData(from urlString: String, itemsComplitionHandler: @escaping (Result<Response, Error>)->Void) {
        let url = URL(string: urlString)

        URLSession.shared.dataTask(with: url!) { data, response, error in
                
                guard let data = data, error == nil else { print("Ошибка получения данных"); return}
                            
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let result = try decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        itemsComplitionHandler(.success(result))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        print("Не получается сконвертировать JSON: \(error)")
                        itemsComplitionHandler(.failure(error))
                    }
                    
                }
            
        }.resume()
            
    }
    
}
