//
//  EmployeeListVC.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit
import FloatingPanel

class EmployeeListVC: BaseViewController<EmployeeListVCRootView>  {
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    private let employeeProvider = ApiProvider()
    
    private let tabs = Department.allCases // статическое поле allCases генерирует сам свифт - достаточно добавить CaseIterable протокол енаму
    
    private var shouldShowBirthday: Bool = false
    private var searchText: String = "" // строка по которой фильтруем
    private var selectedDepartment: Department? = nil // отдел по которому фильтруем
    
    private var employee: [EmployeeModel] = [] // список сотрудников который мы получили

    private var tableModel: [[EmployeeModel]]  = []
    
    private func updateTableModel() {
        // если каждый раз полагать на вычисляемые переменные - со временем начинает лагать - для каждой ячейки идет вычисление всего заново, а элементов слишком много.
        // ПОэтому я каждый раз при изменении фильтров ьбуду один раз пересчитывать итоговую модель для таблицы, сохранять ее в переменную и оттуда уже выводить
        
        let filteredEmployee = employee
            .filter({
                $0.department == selectedDepartment || selectedDepartment == nil // возвращаем только сотрудников с отделом как текущий, а если текущтй nil - вернутся все, без филтрации
            })
            .filter({
                $0.firstName.starts(with: searchText) || $0.lastName.starts(with: searchText) || searchText.isEmpty // добавил условие searchText.isEmpty чтоб сохранились все элементы если поиск пустой
            })
        
        
        tableModel = [
            filteredEmployee.filter { isCurrentYearBirthday($0.birthdayDate) || !shouldShowBirthday }, // если не делим на др - за счет !shouldShowBirthday все окажутся в первой секции
            filteredEmployee.filter { !isCurrentYearBirthday($0.birthdayDate) && shouldShowBirthday } // self не надо - это non esacping closure. за счет shouldShowBirthday секция будет пуста, если не надо показывать др
        ].filter({ !$0.isEmpty })
        
        mainView.employeeTableView.reloadData()
    }
    
    // убрал var modelController = ModelController()
    // очень странно хранить такой контроллер, который просто держит в себе один объект, но при том зачем-то в контроллере со списком
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.errorView.tryAgainButton.addTarget(self, action: #selector(checkConnection(_:)), for: .touchUpInside)
        
        mainView.employeeTableView.refreshControl = refreshControl
        
        mainView.employeeTableView.separatorStyle = .none
        mainView.employeeTableView.separatorColor = .clear
        
        mainView.employeeTableView.delegate = self
        mainView.employeeTableView.dataSource = self
        mainView.topTabsCollectionView.delegate = self
        mainView.topTabsCollectionView.dataSource = self
        
        mainView.employeeTableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        mainView.employeeTableView.rowHeight = 90
        
        mainView.topTabsCollectionView.register(TopTabsCollectionViewCell.self, forCellWithReuseIdentifier: TopTabsCollectionViewCell.identifier)
        
        mainView.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        mainView.searchTextField.rightImageButton.addTarget(self, action: #selector(rightViewButtonClicked(_:)), for: .touchUpInside)
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
        
        updateDepartmentSelection()// обновляем выбор на старте, пусть будет
        
        refetchData()
        
        navigationItem.title = "MainNavViewController"
        
    }
    
    func refetchData() {
        
        refreshControl.beginRefreshing()
        employeeProvider.getData(EmployeeList.self, from: "/kode-education/trainee-test/25143926/users") { result in // поправил url - теперь нам надо писать только изменяемую часть
            
            self.refreshControl.endRefreshing()
            
            switch result {
            case let .success(responseData):
                self.employee = responseData.items
                self.mainView.setMainView()
                self.updateTableModel()
            case .failure(_):
                self.mainView.setErrorView()
            }
        }
    }

    
    @objc
    private func didPullToRefresh(_ sender: UIRefreshControl) {
        
        self.mainView.setMainView()
        
        refetchData()
    }
    
    @objc
    private func checkConnection(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 0.3, green: 0.5, blue: 0.8, alpha: 0.3)
        
        self.mainView.setMainView()
        
        refetchData()
        
    }
    
    // добавил private - по умолчанию пиши все private и только если надо чтоб было доступно из других классов не пиши
    @objc
    private func textFieldDidChange(_ sender: UITextField) {// принято называть sender
        
        mainView.setSearchEditingMode()
        searchText = sender.text ?? ""
        
        if tableModel.isEmpty {
            mainView.setNotFoundView()
        } else {
            mainView.setIsFoundView()
        }
        
        updateTableModel()
    }
    
    @objc
    private func cancelClicked(_ sender: UIButton) {
        
        mainView.searchTextField.text = ""
        searchText = ""
        
        updateTableModel()
    }
    
    private func updateRightViewSelection(){
        
        if shouldShowBirthday {
            mainView.searchTextField.rightImageButton.isSelected = true
        } else {
            mainView.searchTextField.rightImageButton.isSelected = false
        }
    }
    
    /// Это чтобы посчитать, в этом году будет день рождения или уже в следующем.
    /// Если число отрицательное - в следующем году. Если положительное - в этом
    // Вот если тебе надо разделять только на текущий и следующий годы, то зачем инт? Это только сбивает. Возвращай бул
    private func isCurrentYearBirthday(_ birthdayDate: Date?) -> Bool {
        
        guard let date = birthdayDate else { return false }
        
        let calendar = Calendar.current
        let dateCurrent = Date()
            
        let dateComponentsNow = calendar.dateComponents([.day, .month, .year], from: dateCurrent)
            
        let birthdayDateComponents = calendar.dateComponents([.day, .month], from: date)
            
        var bufferDateComponents = DateComponents()
        bufferDateComponents.year = dateComponentsNow.year
        bufferDateComponents.month = birthdayDateComponents.month
        bufferDateComponents.day = birthdayDateComponents.day
            
        // guard , ровно как и if можно днлать на несколько строче сразу
        guard
            let bufferDate = calendar.date(from: bufferDateComponents),
            let dayDifference = calendar.dateComponents([.day], from: dateCurrent, to: bufferDate).day
        else { return false }
        
        return dayDifference >= 0
    }
    
    private func updateDepartmentSelection() {
        mainView.topTabsCollectionView.visibleCells.compactMap({ $0 as? TopTabsCollectionViewCell }).forEach({ cell in
            let shouldBeSelected = cell.model == self.selectedDepartment
            cell.setCellSelected(shouldBeSelected)
        })
    }
    
    @objc
    func rightViewButtonClicked(_ sender: UIButton){
       
        let floatingPanelController = FloatingPanelController()
        
        floatingPanelController.delegate = self
        
        let sortingVC = SortingViewController()
        
        sortingVC.delegate = self
        floatingPanelController.set(contentViewController: sortingVC)
        floatingPanelController.isRemovalInteractionEnabled = true
        floatingPanelController.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatingPanelController.backdropView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        floatingPanelController.backdropView.alpha = 1
        floatingPanelController.layout = ModalPanelLayout()
        
        present(floatingPanelController, animated: true, completion: nil)
    }
}

// extension for UITableView

extension EmployeeListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { max(tableModel.count, 1) }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if employee.isEmpty {
            return 15
        }
        
        return tableModel.at(section)?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || tableModel.at(section)?.isEmpty != false { return nil }
        
        return HeaderSectionView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier) as! EmployeeTableViewCell
        cell.shouldShowBirthday = shouldShowBirthday
        
        let employee = tableModel.at(indexPath.section)?.at(indexPath.row)
        
        cell.setData(employee?.listCellModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let employee = tableModel.at(indexPath.section)?.at(indexPath.row) else { return }
        
        let vc = DetailsVC() // просто создаем новый инстанс второго экрана
        vc.employee = employee // устанавливаем ему модель
    
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(vc, animated: true)// пушим
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
        
        updateTableModel()
        
        // а вот дальше пойдет обновление ячеек
        updateDepartmentSelection()
        
    }

}

extension EmployeeListVC: FloatingPanelControllerDelegate {

}

extension EmployeeListVC: SortingViewDelegate {
    
    func sortByAlphabet() {
        
        employee.sort(by: { $0.firstName < $1.firstName })

        updateRightViewSelection()
        
        updateTableModel()
    }
    
    func sortByBirthday() {
        
        employee.sort { date1, date2 in return date1.birthdayDate ?? Date() < date2.birthdayDate ?? Date() }
        
        updateTableModel()
        updateRightViewSelection()
    }
    
    func showBirthday(shouldShow: Bool) {
        
        self.shouldShowBirthday = shouldShow
        updateTableModel()
    }
}

class ModalPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full

    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(fractionalInset: 0.3, edge: .bottom, referenceGuide: .safeArea)
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.3
    }
}
