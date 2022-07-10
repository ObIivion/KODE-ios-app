import UIKit
import Rswift

class EmployeeListVCRootView: BaseView {
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor(red: 0.396, green: 0.204, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = R.font.interSemiBold(size: 14)
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
    
    private let separatorLineUnderTabs: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.33))
        view.backgroundColor = UIColor(red: 0.765, green: 0.765, blue: 0.776, alpha: 1)
        
        return view
    }()
    
    let employeeTableView = UITableView()
    
    let errorView = LostInternetConnectionView()
    
    override func setup() {
        backgroundColor = .white
        addSubview(searchTextField)
        addSubview(cancelButton)
        addSubview(employeeTableView)
        addSubview(topTabsCollectionView)
        addSubview(separatorLineUnderTabs)
        addSubview(errorView)
        
        setupConstraints()
        
        setViewDependingOnConnection()
        
    }
    
    private func setupConstraints() {
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -16),
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.widthAnchor.constraint(equalToConstant: 343),
            searchTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 12),
            cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
        
        topTabsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topTabsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 6),
            topTabsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTabsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTabsCollectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        separatorLineUnderTabs.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorLineUnderTabs.topAnchor.constraint(equalTo: topTabsCollectionView.bottomAnchor, constant: 7.67),
            separatorLineUnderTabs.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLineUnderTabs.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLineUnderTabs.heightAnchor.constraint(equalToConstant: 0.33)
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
    
    func setSearchEditingMode(){
        
        NSLayoutConstraint.activate([searchTextField.widthAnchor.constraint(equalToConstant: 265)])
        cancelButton.isHidden = false
        layoutIfNeeded()
        
        let leftView = UIImageView()
        leftView.image = R.image.vector_editing()
        self.searchTextField.leftView = leftView
        
    }
    
    func setNotEditingMode() {
        self.searchTextField.transform = CGAffineTransform(scaleX: 1, y: 1)
        let leftView = UIImageView()
        leftView.image = R.image.vector()
        self.cancelButton.isHidden = true
    }
    
}
