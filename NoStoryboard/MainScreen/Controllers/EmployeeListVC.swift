//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit

class EmployeeListVC: UIViewController {

    var tableView = UITableView()
    var employers: Array<Employee> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Designers"
        employers = setDataEmployee()
        
        view.backgroundColor = UIColor(red: 0xE5, green: 0xE5, blue: 0xE5, alpha: 0xFF)
        configureTableView()
        

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
