//
//  ContentViewController.swift
//  practiceForSmeem
//
//  Created by 임주민 on 2023/04/14.
//

import UIKit

import FSCalendar
import SnapKit
import Then

class ContentViewController: UIViewController {
    
    // MARK: - Property
    
    private let weekdayLabels = ["S", "M", "T", "W", "T", "F", "S"]
    
    // MARK: - UI Property
    
    private let calendar = FSCalendar().then {
        $0.appearance.weekdayTextColor = UIColor(red: 0.09, green: 0.09, blue: 0.086, alpha: 1)
        $0.appearance.weekdayFont = UIFont(name: "Pretendard-Light", size: 14)
        $0.appearance.titleDefaultColor = UIColor(red: 0.721, green: 0.721, blue: 0.721, alpha: 1)
        $0.appearance.titleFont = UIFont(name: "Pretendard-Medium", size: 18)
        $0.appearance.headerTitleColor = UIColor(red: 0.721, green: 0.721, blue: 0.721, alpha: 1)
        $0.appearance.headerTitleFont = UIFont(name: "Pretendard-Regular", size: 14)
        $0.appearance.headerMinimumDissolvedAlpha = 0
        $0.appearance.headerDateFormat = "YYYY년 M월"
        $0.headerHeight = 66
        $0.weekdayHeight = 30
        $0.scope = .week
    }
    private let indicator = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor(red: 0.824, green: 0.824, blue: 0.824, alpha: 1)
    }
    private let border = UIView().then {
        $0.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
    }
    private let tmpDiary = UILabel().then {
        $0.lineBreakMode = .byCharWrapping
        $0.text = "I watched Avatar with my boyfriend at Hongdae CGV. I should have skimmed the previous season - Avatar1.. I really couldn’t ..."
        $0.numberOfLines = 0
        $0.textColor = .gray
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setDelegate()
        setSwipe()
        setCalendar()
        setLayout()
    }
    
    // MARK: - @objc
    
    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        if (swipe.location(in: self.view).y < border.frame.origin.y+20) {
            calendar.setScope((swipe.direction == .up) ? .week : .month, animated: true)
        }
    }
    
    // MARK: - Custom Method
    
    private func setBackgroundColor() {
        view.backgroundColor = .white
    }
    private func setDelegate() {
        calendar.dataSource = self
        calendar.delegate = self
    }
    private func setCalendar() {
        for i in 0...6 {
            calendar.calendarWeekdayView.weekdayLabels[i].text = weekdayLabels[i]
        }
    }
    private func setSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:))).then {
            $0.direction = .up
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:))).then {
            $0.direction = .down
        }
        view.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeDown)
    }
    private func setLayout() {
        view.addSubviews([calendar, indicator, border, tmpDiary])
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(460)
            $0.width.equalTo(view.frame.width-50)
        }
        indicator.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(4)
            $0.width.equalTo(72)
        }
        border.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(30)
            $0.height.equalTo(6)
            $0.width.equalTo(view.frame.width)
        }
        tmpDiary.snp.makeConstraints {
            $0.top.equalTo(border.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(view.frame.width-30)
        }
    }
}

// MARK: - Extension : FSCalendarDelegate

extension ContentViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        view.layoutIfNeeded()
    }
}

// MARK: - Extension : FSCalendarDataSource

extension ContentViewController: FSCalendarDataSource { }
