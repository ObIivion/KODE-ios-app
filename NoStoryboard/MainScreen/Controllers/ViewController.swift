//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let tabs = Department.allCases // статическое поле allCases генерирует сам свифт - достаточно добавить CaseIterable протокол енаму
    
    private var searchText: String = "" // строка по которой фильтруем
    private var selectedDepartment: Department = .design // отдел по которому фильтруем
    
    private var employee: [EmployeeModel] = [] // список сотрудников который мы получили
    
    private var filteredEmployee: [EmployeeModel] { // это как-бы переменная, но на самом деле в нее нельзя записать, она каждый раз будет вычиляться заново, по сути это только getter, такие переменные больше функции чем переменные
        return employee
            .filter({
                $0.department == selectedDepartment // возвращаем только сотрудников с отделом как текущий
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty // добавил условие searchText.isEmpty чтоб сохранились все элементы если поиск пустой
            })
    }

    
    private let employeeProvider = ApiProvider()
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
        
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.employeeTableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
    }
    // фильтрация по вводу
    @objc func textFieldDidChange(_ sender: UITextField) {// принято называть sender
        
        searchText = sender.text ?? ""
        
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
        filteredEmployee.count // теперь всегда данные берем из filtered
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier) as! EmployeeTableViewCell
        let employee = filteredEmployee[indexPath.row]
        cell.set(employee: employee)
        
        return cell
    }
}

// extension for UICollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabsCollectionViewCell.identifier, for: indexPath) as! TopTabsCollectionViewCell
        cell.label.text = tabs[indexPath.item].title // используем title который вручную прописали у department
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDepartment = tabs[indexPath.item]
        employeeTableView.reloadData()
        // больше нам не надо делать огромный switch - вся фильтрация пройдет в filteredEmployee и просто сравнится у кого department такой же как текущий selectedDepartment, а selectedDepartment мы только что установили, зная индекс
    }

    
}
