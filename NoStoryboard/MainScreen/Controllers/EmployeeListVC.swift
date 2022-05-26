//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit

class EmployeeListVC: UIViewController {

    private let tableView = UITableView()
    private var employers: [EmployeeModel] = []
    private let employeeProvider = ApiProvider<EmployeeList>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Designers"
        
        view.backgroundColor = UIColor(red: 0xE5, green: 0xE5, blue: 0xE5, alpha: 0xFF)
        configureTableView()
        
        let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        employeeProvider.getData(from: urlString, itemsComplitionHandler: self.requestCompletionHandler)
        print("---->>>>>_>______>>__>_>__")
    }
    
    func requestCompletionHandler(result: Result<EmployeeList, Error>){
        
        switch result {
        case let .success(responseData):
            self.employers = responseData.items
            self.tableView.reloadData()
        case let .failure(error):
            print(error)
        }
        
    }
       
    func configureTableView() {
        
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        // set row height
        tableView.rowHeight = 90
        // register cells
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        // set constraints
        tableView.pin(superView: view)
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension EmployeeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as! EmployeeCell
        let employee = employers[indexPath.row]
        cell.set(employee: employee)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employers.count
    }
    
}
