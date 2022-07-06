//
//  SortingViewController.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.06.2022.
//

import UIKit
import Rswift

protocol SortingViewDelegate: AnyObject {
    
//    var thisYearBirthdayEmployee: [EmployeeModel] {get set}
//    
//    var nextYearBirthdayEmployee: [EmployeeModel] {get set}
//    
//    func checkMonths(birthdayDate: Date?)
    
    func sortByAlphabet()
    
    func sortByBirthday()
    
    func showBirthday(shouldShow: Bool)
}



class SortingViewController: BaseViewController<BottomSheetSortingView> {
    
    weak var delegate: SortingViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.alphabetSortRadioButton.addTarget(self, action: #selector(self.alphabetSortButtonClicked(_:)), for: .touchUpInside)
        mainView.birthdaySortRadioButton.addTarget(self, action: #selector(self.birthdaySortButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc
    private func alphabetSortButtonClicked(_ sender: UIButton) {
        
        mainView.alphabetSortRadioButton.isSelected = true
        mainView.birthdaySortRadioButton.isSelected = false
        
        delegate?.showBirthday(shouldShow: false)
        
        delegate?.sortByAlphabet()
        
    }
    
    @objc
    private func birthdaySortButtonClicked(_ sender: UIButton) {
        
        mainView.alphabetSortRadioButton.isSelected = false
        mainView.birthdaySortRadioButton.isSelected = true
        delegate?.showBirthday(shouldShow: true)
        delegate?.sortByBirthday()
        
    }
}
