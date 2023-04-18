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
    
    private var isWeek = false
    
    // MARK: - UI Property
    
    private var calendar = FSCalendar().then {
        $0.scope = .week
    }
    private var indicator = UIView().then {
        $0.backgroundColor = .lightGray
    }
    private var border = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setDelegate()
        setSwipe()
        setLayout()
    }
    
    // MARK: - @objc

    @objc func swipeEvent(_ swipe: UISwipeGestureRecognizer) {
        print("유저 이동 \(swipe.location(in: self.view).y)")
        if swipe.direction == .up {
            if (swipe.location(in: self.view).y < 490.0) {
                calendar.setScope(.week, animated: true)
            }
        } else if swipe.direction == .down {
            if (swipe.location(in: self.view).y < 270.0) {
                calendar.setScope(.month, animated: true)
            }
        }
    }
    
    // MARK: - Custom Method
    
    func setBackgroundColor() {
        view.backgroundColor = .white
    }
    func setDelegate() {
        calendar.dataSource = self
        calendar.delegate = self
    }
    func setSwipe() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:))).then {
            $0.direction = .up
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeEvent(_:))).then {
            $0.direction = .down
        }
        
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)

        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    func setLayout() {
        view.addSubviews([calendar, indicator, border])
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(360)
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
    }
}

// MARK: - Extension : FSCalendar
extension ContentViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        view.layoutIfNeeded()
    }
}
