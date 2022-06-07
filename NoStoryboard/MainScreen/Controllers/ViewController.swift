//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
   private let tabNames = ["Designers", "Analysts", "Managers", "iOS",
                    "Android", "QA", "Frontend", "Backend",
                    "HR", "PR", "Back Office", "Support"]
    
    private var employee: [EmployeeModel] = []
    private var filteredEmployee: [EmployeeModel] = []
    private var employeeIsFiltered = false
    private let employeeProvider = ApiProvider<EmployeeList>()
    
    private let searchTextField = SearchTextField(inset: UIEdgeInsets(top: 10, left: 44, bottom: 10, right: 35))
    
    private let topTabsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let tab = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return tab
    }()
    
    private let employeeTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor =  .white
        view.addSubview(searchTextField)
        view.addSubview(employeeTableView)
        view.addSubview(topTabsCollectionView)
        setupViews()
        
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        employeeTableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        employeeTableView.rowHeight = 90
        
        topTabsCollectionView.register(TopTabsCollectionViewCell.self, forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        topTabsCollectionView.delegate = self
        topTabsCollectionView.dataSource = self
        
        let urlString = "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users"
        employeeProvider.getData(from: urlString) { result in
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.employeeTableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(paramTarget:)), for: .editingChanged)
    
    }
    // фильтрация по вводу
    @objc func textFieldDidChange(paramTarget: UITextField){
        
        filteredEmployee.removeAll()
        
        guard let query = paramTarget.text else { return }
        
        for i in employee{
            if i.firstName.starts(with: query) {
                filteredEmployee.append(i)
            }
        }
        employeeTableView.reloadData()
    }
    
    //constraints
    func setupViews(){
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
        ])
        
        self.topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.topTabsCollectionView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 6).isActive = true
        self.topTabsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.topTabsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.topTabsCollectionView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.employeeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.employeeTableView.topAnchor.constraint(equalTo: self.topTabsCollectionView.bottomAnchor, constant: 22).isActive = true
        self.employeeTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.employeeTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.employeeTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

// extension for UITableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredEmployee.isEmpty {
        return employee.count
        } else {
            return filteredEmployee.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier) as! EmployeeTableViewCell
        
        if (filteredEmployee.isEmpty){
            let employee = employee[indexPath.row]
            cell.set(employee: employee)
            return cell
        } else {
            let employee = filteredEmployee[indexPath.row]
            cell.set(employee: employee)
            return cell
        }
    }
}

// extension for UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabsCollectionViewCell.identifier, for: indexPath) as! TopTabsCollectionViewCell
        cell.label.text = tabNames[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTab = tabNames[indexPath.item]
        tabSelectedFilter(tabName: selectedTab)
    }
    
    func tabSelectedFilter(tabName: String){
        
        filteredEmployee.removeAll()
        
        switch tabName {
            
        case "Designers":
            for i in employee {
                if i.department == "design" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Analysts":
            for i in employee {
                if i.department == "analytics" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Managers":
            for i in employee {
                if i.department == "management" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "iOS":
            for i in employee {
                if i.department == "ios" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Android":
            for i in employee {
                if i.department == "android" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "QA":
            for i in employee {
                if i.department == "qa" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Frontend":
            for i in employee {
                if i.department == "frontend" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Backend":
            for i in employee {
                if i.department == "backend" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "HR":
            for i in employee {
                if i.department == "hr" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "PR":
            for i in employee {
                if i.department == "pr" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Back Office":
            for i in employee {
                if i.department == "back_office" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        case "Support":
            for i in employee {
                if i.department == "support" {
                    filteredEmployee.append(i)
                }
            }
            employeeTableView.reloadData()
        default:
            employeeTableView.reloadData()
        }
        
    }
    
}

//["Designers", "Analysts", "Managers", "iOS",
//                 "Android", "QA", "Frontend", "Backend",
//                 "HR", "PR", "Back Office", "Support"]
