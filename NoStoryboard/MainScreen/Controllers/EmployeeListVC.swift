//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit

class EmployeeListVC: BaseViewController<EmployeeListVCRootView> {
    
    private let tabs = Department.allCases // статическое поле allCases генерирует сам свифт - достаточно добавить CaseIterable протокол енаму
    
    private var searchText: String = "" // строка по которой фильтруем
    private var selectedDepartment: Department? = nil // отдел по которому фильтруем
    
    private var employee: [EmployeeModel] = [] // список сотрудников который мы получили
    
    private var filteredEmployee: [EmployeeModel] { // это как-бы переменная, но на самом деле в нее нельзя записать, она каждый раз будет вычиляться заново, по сути это только getter, такие переменные больше функции чем переменные
        return employee
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil // возвращаем только сотрудников с отделом как текущий, а если текущтй nil - вернутся все, без филтрации
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty // добавил условие searchText.isEmpty чтоб сохранились все элементы если поиск пустой
            })
    }

    
    private let employeeProvider = ApiProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.employeeTableView.delegate = self
        mainView.employeeTableView.dataSource = self
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        
        mainView.employeeTableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        mainView.employeeTableView.rowHeight = 90
        
        mainView.topTabsCollectionView.register(TopTabsCollectionViewCell.self, forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        
        mainView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.employeeTableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        
        
    }
    // фильтрация по вводу
    @objc func textFieldDidChange(_ sender: UITextField) {// принято называть sender
        
        searchText = sender.text ?? ""
        
        mainView.employeeTableView.reloadData()
    }
    
    //constraints
    func setupViews(){
        
        
    }
    
}

// extension for UITableView
extension EmployeeListVC: UITableViewDelegate, UITableViewDataSource {
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
extension EmployeeListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabsCollectionViewCell.identifier, for: indexPath) as! TopTabsCollectionViewCell
        cell.label.text = tabs[indexPath.item].title // используем title который вручную прописали у department
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedDepartment == tabs[indexPath.item] {
            selectedDepartment = nil // если я тапаю на ту же ячейку что и выбрана - фильтр снимется и покажутся все без фильтрации по профессии
        } else {
            selectedDepartment = tabs[indexPath.item] // если я тапаю на ячейку с дркгим фильтром - просто сменится департмент по которому фильтрую
        }
        
        mainView.employeeTableView.reloadData()
        // больше нам не надо делать огромный switch - вся фильтрация пройдет в filteredEmployee и просто сравнится у кого department такой же как текущий selectedDepartment, а selectedDepartment мы только что установили, зная индекс
    }

    
}
