//
//  SortingViewController.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 22.06.2022.
//

import UIKit
import Rswift

protocol SortingViewDelegate {
    
    func sortByAlphabet()
    
    func sortByBirthday()
    
}

class SortingViewController: BaseViewController<BottomSheetSortingView> {
    
    var delegate: SortingViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.alphabetSortRadioButton.addTarget(self, action: #selector(self.alphabetSortButtonClicked(_:)), for: .touchUpInside)
        mainView.birthdaySortRadioButton.addTarget(self, action: #selector(self.birthdaySortButtonClicked(_:)), for: .touchUpInside)
        
    }
    
    @objc
    func alphabetSortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortRadioButton.setBackgroundImage(R.image.isSelected(), for: .normal)
        mainView.birthdaySortRadioButton.setBackgroundImage(R.image.unSelected(), for: .normal)
        
        delegate?.sortByAlphabet()
        
    }
    
    @objc
    func birthdaySortButtonClicked(_ sender: UIButton) {
        mainView.birthdaySortRadioButton.setBackgroundImage(R.image.isSelected(), for: .normal)
        mainView.alphabetSortRadioButton.setBackgroundImage(R.image.unSelected(), for: .normal)
        
        delegate?.sortByBirthday()
        
    }

}
