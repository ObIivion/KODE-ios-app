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
    
    // убрал var modelController = ModelController()
    // очень странно хранить такой контроллер , который просто держит в себе один объект, но при том зачем-то в контроллере со списком
    
    
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
        
        updateDepartmentSelection()// обновляем выбор на старте, пусть будет
        
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.employeeTableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
        
        navigationItem.title = "MainNavViewController"
        
    }
    
    // добавил private - по умолчанию пиши все private и только если надо чтоб было доступно из других классов не пиши
    @objc private func textFieldDidChange(_ sender: UITextField) {// принято называть sender
        
        searchText = sender.text ?? ""
        
        mainView.employeeTableView.reloadData()
    }
    
    private func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == self.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailsVC() // просто создаем новый инстанс второго экрана
        vc.employee = filteredEmployee[indexPath.item] // устанавливаем ему модель
        
        navigationController?.pushViewController(vc, animated: true) // пушим
    }
}

// extension for UICollectionView
extension EmployeeListVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopTabsCollectionViewCell.identifier, for: indexPath) as! TopTabsCollectionViewCell
        
        cell.setModel(tabs[indexPath.item]) // по хорошему все сабвьюшки ячеек, да и впрочем остальных вьюшек должны быть приватными, за редким исключением
        // поэтому я сделал так что в ячеку передается целиком департмент - по сути это модкль для ячейки
        
        
        cell.setCellSelected(tabs[indexPath.item] == selectedDepartment)
        // теперь ячейка сама опредляет как себя вести если она выбрана или нет, мы просто усланавливаем значение сотит ли ей отображаться как выбранной
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedDepartment == tabs[indexPath.item] {
            selectedDepartment = nil
        } else {
            selectedDepartment = tabs[indexPath.item]
        }
        mainView.employeeTableView.reloadData()
        // пускай здесь отсанется только логика
        
        // а вот дальше пойдет обновление ячеек
        updateDepartmentSelection()
        
    }

}
