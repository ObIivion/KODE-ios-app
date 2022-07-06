import UIKit

class EmployeeListVCRootView: BaseView {
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "Gill Sans SemiBold" , size: 16)
        button.isHidden = true
        return button
    }()
    
    var searchTextField = SearchTextField(inset: UIEdgeInsets(top: 10, left: 44, bottom: 10, right: 35))
    
    let topTabsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let tab = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tab.backgroundColor = .clear
        return tab
    }()
    
    let employeeTableView = UITableView()
    
    let errorView = LostInternetConnectionView()
    
    override func setup() {
        backgroundColor = .white
        addSubview(searchTextField)
        addSubview(cancelButton)
        addSubview(employeeTableView)
        addSubview(topTabsCollectionView)
        addSubview(errorView)
        
        setupConstraints()
        
        setViewDependingOnConnection()
        
    }
    
    private func setupConstraints() {
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14),
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 12),
            cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor)
        ])
        
        topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 6),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        employeeTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeTableView.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 22),
            employeeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            employeeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            employeeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setViewDependingOnConnection(){

        NetworkMonitor.shared.startMonitoring()
        print("T/f \(NetworkMonitor.shared.isConnected)")
        print("ПРОВЕРОЧКА ИНТЕРНЕТА")

        if NetworkMonitor.shared.isConnected {
            print("Интернет присутствует")
            errorView.isHidden = true
            searchTextField.isHidden = false
            employeeTableView.isHidden = false
            topTabsCollectionView.isHidden = false
        } else {
            print("Интернет отсутствует")
            searchTextField.isHidden = true
            employeeTableView.isHidden = true
            topTabsCollectionView.isHidden = true
            errorView.isHidden = false
        }
        
        NetworkMonitor.shared.stopMonitoring()
    }
    
    func setErrorView(){
        
        searchTextField.isHidden = true
        employeeTableView.isHidden = true
        topTabsCollectionView.isHidden = true
        errorView.isHidden = false
        
    }
    
    func setMainView(){
        
        errorView.isHidden = true
        searchTextField.isHidden = false
        employeeTableView.isHidden = false
        topTabsCollectionView.isHidden = false
        
    }
    
}
