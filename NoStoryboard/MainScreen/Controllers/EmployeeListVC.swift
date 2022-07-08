//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit
import FloatingPanel

class EmployeeListVC: BaseViewController<EmployeeListVCRootView>  {
    
    private var floatingPanelController = FloatingPanelController()
    
    var shouldShowBirthday: Bool = false
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        return refresh
        
    }()
    
    private let tabs = Department.allCases // статическое поле allCases генерирует сам свифт - достаточно добавить CaseIterable протокол енаму
    
    private var searchText: String = "" // строка по которой фильтруем
    private var selectedDepartment: Department? = nil // отдел по которому фильтруем
    
    private var employee: [EmployeeModel] = [] // список сотрудников который мы получили
    
    var filteredEmployee: [EmployeeModel] { // это как-бы переменная, но на самом деле в нее нельзя записать, она каждый раз будет вычиляться заново, по сути это только getter, такие переменные больше функции чем переменные
        return employee
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil // возвращаем только сотрудников с отделом как текущий, а если текущтй nil - вернутся все, без филтрации
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty // добавил условие searchText.isEmpty чтоб сохранились все элементы если поиск пустой
            })
    }
    
    var thisYearBirthdayEmployee: [EmployeeModel] {
        
        return filteredEmployee.filter {
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) > 0
        }
    }
    
    var nextYearBirthdayEmployee: [EmployeeModel] {
        
        return filteredEmployee.filter {
            
            return self.calculateDayDifference(birthdayDate: $0.birthdayDate) < 0
            
        }
    }
    
    var employeeModelForSections: [[EmployeeModel]] {
        
        return [thisYearBirthdayEmployee, nextYearBirthdayEmployee]
        
    }

    private let employeeProvider = ApiProvider()
    
    // убрал var modelController = ModelController()
    // очень странно хранить такой контроллер , который просто держит в себе один объект, но при том зачем-то в контроллере со списком
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.errorView.tryAgainButton.addTarget(self, action: #selector(checkConnection(_:)), for: .touchUpInside)
        
        setupFloatingPanel()
        
        mainView.employeeTableView.refreshControl = refreshControl
        
        mainView.employeeTableView.delegate = self
        mainView.employeeTableView.dataSource = self
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        
        mainView.employeeTableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        mainView.employeeTableView.rowHeight = 90
        
        mainView.topTabsCollectionView.register(TopTabsCollectionViewCell.self, forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        
        mainView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        mainView.searchTextField.rightImageButton.addTarget(self, action: #selector(rightViewButtonClicked(_:)), for: .touchUpInside)
        
        updateDepartmentSelection()// обновляем выбор на старте, пусть будет
        
        // вот это замыкание пусть останется просто чтобы было куда смотреть, а то пиздец. Я сделал функцию из этого замыкания и она даже заработала, но не сказал бы, что понимаю почему это сработало (ну +- только если и то не факт что напишу аналогично сам)
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.setMainView()
                self.mainView.employeeTableView.reloadData()
            case .failure(_):
                self.mainView.setErrorView()
            }
        }
        
        navigationItem.title = "MainNavViewController"
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        
        self.mainView.setMainView()
        
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.setMainView()
                self.shouldShowBirthday = false
                self.mainView.employeeTableView.reloadData()
                self.refreshControl.endRefreshing()
            case let .failure(error):
                self.refreshControl.endRefreshing()
                self.mainView.setErrorView()
                print(error)
            }
        }
    }
    
    @objc
    private func checkConnection(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 0.3)
        
        self.mainView.setMainView()
        
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users", self.loadData(result:))
        
    }
    
    // добавил private - по умолчанию пиши все private и только если надо чтоб было доступно из других классов не пиши
    @objc
    private func textFieldDidChange(_ sender: UITextField) {// принято называть sender
        
        searchText = sender.text ?? ""
        
        mainView.employeeTableView.reloadData()
    }
    
    private func loadData(result: Result<EmployeeList, Error>) {
        
        switch result {
        case let .success(responseData):
            self.employee = responseData.items
            self.mainView.setMainView()
            self.mainView.employeeTableView.reloadData()
        case let .failure(error):
            self.mainView.setErrorView()
            
        }
    }
    
    private func formatDate (date: Date?) -> String {

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.setLocalizedDateFormatFromTemplate("dd MMM")

        if let date = date {
            
            var date = formatter.string(from: date)
            
            if date.count == 7 {
                date.removeLast()
            }
            
            if date.count == 8 {
                date.removeLast(2)
            }
            return date
        }
        
        return "Дата не была получена"
    }
    
    /// Это чтобы посчитать, в этом году будет день рождения или уже в следующем.
    /// Если число отрицательное - в следующем году. Если положительное - в этом
    
    private func calculateDayDifference(birthdayDate: Date?) -> Int {
        
        guard let date = birthdayDate else { return 0}
        
        let calendar = Calendar.current
        let dateCurrent = Date()
            
        let dateComponentsNow = calendar.dateComponents([.day, .month, .year], from: dateCurrent)
            
        let birthdayDateComponents = calendar.dateComponents([.day, .month], from: date)
            
        var bufferDateComponents = DateComponents()
        bufferDateComponents.year = dateComponentsNow.year
        bufferDateComponents.month = birthdayDateComponents.month
        bufferDateComponents.day = birthdayDateComponents.day
            
        guard let bufferDate = calendar.date(from: bufferDateComponents) else { return 0 }
                
        guard let dayDifference = calendar.dateComponents([.day], from: dateCurrent, to: bufferDate).day else { return 0 }
        
        return dayDifference
    }
    
    private func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == self.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
    
    @objc
    func rightViewButtonClicked(_ sender: UIButton){
        
        floatingPanelController.addPanel(toParent: self)
        floatingPanelController.hide()
        floatingPanelController.show(animated: true, completion: nil)
                
    }
}

// extension for UITableView

extension EmployeeListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if employee.isEmpty {
            return 15
        } else {
            
        if self.shouldShowBirthday {
           
            return section == 0 ? thisYearBirthdayEmployee.count : nextYearBirthdayEmployee.count
            
        } else {
            return filteredEmployee.count // теперь всегда данные берем из filtered
        }
    }
}
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.shouldShowBirthday ?  2 : 1
        
}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            return HeaderSectionView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier) as! EmployeeTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        if !employee.isEmpty {
            
            if shouldShowBirthday {
                let sortedEmployee = employeeModelForSections[indexPath.section][indexPath.row]
                cell.setData(firstName: sortedEmployee.firstName, lastName: sortedEmployee.lastName, tag: sortedEmployee.userTag, department: sortedEmployee.department, dateBirth: formatDate(date: sortedEmployee.birthdayDate))
                cell.setBirthdayLabelVisibility(shouldShowBirthday: self.shouldShowBirthday)
                cell.setViewWithData()
            } else {
            
        let employee = filteredEmployee[indexPath.row]
            cell.setData(firstName: employee.firstName, lastName: employee.lastName, tag: employee.userTag, department: employee.department, dateBirth: formatDate(date: employee.birthdayDate))
            cell.setBirthdayLabelVisibility(shouldShowBirthday: self.shouldShowBirthday)
            cell.setViewWithData()
            }
        } else {
            cell.setLoadingView()
        }
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

extension EmployeeListVC: FloatingPanelControllerDelegate {
    
    func setupFloatingPanel() {
        
        floatingPanelController.delegate = self
        
        guard let sortingVC = SortingViewController() as? SortingViewController else { return }
        sortingVC.delegate = self
        floatingPanelController.set(contentViewController: sortingVC)
        floatingPanelController.isRemovalInteractionEnabled = true
    }
    
}

extension EmployeeListVC: SortingViewDelegate {
    
    func sortByAlphabet() {
        
        employee.sort(by: { $0.firstName < $1.firstName })
        mainView.employeeTableView.reloadData()
    }
    
    func sortByBirthday() {
        
        print("----- SORTED BY DAY LEFT DR -----")
        employee.sort { date1, date2 in
            guard let date1 = date1.birthdayDate else { return false }
            guard let date2 = date2.birthdayDate else { return false }
            
            var dayDifference1 = calculateDayDifference(birthdayDate: date1)
            var dayDifference2 = calculateDayDifference(birthdayDate: date2)
            
            if (dayDifference1 < 0) {
                dayDifference1 += 365
            }
            
            if dayDifference2 < 0 {
                dayDifference2 += 365
            }
            
            return dayDifference1 < dayDifference2
        }
        mainView.employeeTableView.reloadData()
    }
    
    func showBirthday(shouldShow: Bool){
        
        self.shouldShowBirthday = shouldShow
        mainView.employeeTableView.reloadData()
    }
}
    
extension EmployeeListVC: UITextFieldDelegate {
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.searchTextField.rightImageButton.isHidden = true
        mainView.cancelButton.isHidden = false
        mainView.searchTextField.placeholder = ""
        
        let leftImage = UIImageView(frame: .zero)
        leftImage.image = R.image.vector_editing()
        mainView.searchTextField.leftViewMode = .whileEditing
        mainView.searchTextField.leftView = leftImage
    }
    
}
