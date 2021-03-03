//
//  CalculateDDayViewController.swift
//  LoveIngAPP
//
//  Created by JEON JUNHA on 2021/03/02.
//

import UIKit
class CalculateDDayViewController: UIViewController {
    
    let dDayLabel = UILabel()
    let cal = UIDatePicker()
    let todayLabel = UILabel()
    let resultTextField = UITextField()
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        calculateDays()
    }
    func setUI() {
        
        resultTextField.borderStyle = .roundedRect
        if #available(iOS 13.4, *) {
            //DatePicker스타일 변경
            cal.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
        }
        [dDayLabel, cal, todayLabel, resultTextField].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        cal.datePickerMode = .date
        cal.addTarget(self, action: #selector(changed), for: .valueChanged)
        NSLayoutConstraint.activate([
            
            todayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cal.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 20),
            cal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
//            dDayLabel.topAnchor.constraint(equalTo: cal.bottomAnchor, constant: 10),
//            dDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            dDayLabel.heightAnchor.constraint(equalToConstant: 50),
//
            
            resultTextField.topAnchor.constraint(equalTo: cal.topAnchor),
            resultTextField.leadingAnchor.constraint(equalTo: cal.trailingAnchor, constant: 30),
            resultTextField.heightAnchor.constraint(equalToConstant: 40),
            
            
            
        ])
    }
    @objc
    func changed() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
//        dateformatter.dateStyle = .short
//        dateformatter.timeStyle = .none
        let date = dateformatter.string(from: cal.date)
        selectedDate = cal.date
        dDayLabel.text = date
        
        let calendar = Calendar.current
        let date3 = Date()
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date3)
        let date2 = calendar.startOfDay(for: selectedDate)

        print("\(date), \(selectedDate)")
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let dDay = components.day
        resultTextField.text = "\(-(dDay ?? 0))"
    }
    func calculateDays() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy. MM. dd."
        let time = dateformatter.string(from: date)
        todayLabel.text = "\(time)"
        
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
//        let year =  components.year
//        let month = components.month
//        let day = components.day
//        let comp = calendar.dateComponents([.year], from: date)
//        todayLabel.text = "\(year ?? 0)년 \(month ?? 0)월 \(day ?? 0)일"
    }
}
