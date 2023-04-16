//
//  ViewController.swift
//  practiceForSmeem
//
//  Created by 임주민 on 2023/04/14.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: - Property
    private var isWeek = true
    var calendarHeight: NSLayoutConstraint!
    
    // MARK: - UI Property
    private var calendar = FSCalendar().then {
        $0.scope = .week
    }
    
    private lazy var button = UIButton().then {
        $0.setTitle("버튼버튼", for: .normal)
        $0.backgroundColor = .cyan
        $0.addTarget(self, action: #selector(changeButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setLayout()
        setDelegate()
    }
     
    // MARK: - @objc
    @objc func changeButtonClicked() {
        isWeek.toggle()
        calendar.scope = isWeek ? .week : .month
    }
    
    // MARK: - Custom Method
    func setBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func setDelegate() {
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    func setLayout() {
        view.addSubviews([calendar, button])
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(450)
            $0.width.equalTo(UIScreen.main.bounds.size.width-50)
        }
        
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp.top).offset(600)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }
}

extension ViewController: FSCalendarDataSource, FSCalendarDelegate { }
