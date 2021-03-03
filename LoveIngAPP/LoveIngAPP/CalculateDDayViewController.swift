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
    var changedDate = Date()
    var dDay = 0
    let dDayButton = UIButton()
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer .frame = view.bounds
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
        self.view.layer.addSublayer(gradientLayer)
        view.backgroundColor = .white
        setUI()
        calculateDays()
    }
    func setUI() {
        
        resultTextField.borderStyle = .roundedRect
        if #available(iOS 13.4, *) {
            //DatePicker스타일 변경
            cal.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        [cal, todayLabel, resultTextField, dDayButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        dDayButton.setTitle("D-Day", for: .normal)
        dDayButton.backgroundColor = .systemBlue
        dDayButton.addTarget(self, action: #selector(CalculateDday(_:)), for: .touchUpInside)
        
        resultTextField.textAlignment = .center
        cal.datePickerMode = .date
        cal.addTarget(self, action: #selector(changed), for: .valueChanged)
        NSLayoutConstraint.activate([
            
            todayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            todayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            cal.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            cal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //            dDayLabel.topAnchor.constraint(equalTo: cal.bottomAnchor, constant: 10),
            //            dDayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //            dDayLabel.heightAnchor.constraint(equalToConstant: 50),
            //
            
            resultTextField.bottomAnchor.constraint(equalTo: cal.topAnchor, constant: -100),
            resultTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultTextField.widthAnchor.constraint(equalToConstant: 80),
            
            dDayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dDayButton.topAnchor.constraint(equalTo: resultTextField.bottomAnchor, constant: 20),
            dDayButton.widthAnchor.constraint(equalToConstant: 60),
            dDayButton.heightAnchor.constraint(equalToConstant: 28)
            
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
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: changedDate)
        let date2 = calendar.startOfDay(for: selectedDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        dDay = components.day ?? 0
        resultTextField.text = "\(-(dDay))"
    }
    func calculateDays() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy. MM. dd."
        let time = dateformatter.string(from: date)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        
        todayLabel.text = "\(time)"
        todayLabel.font = todayLabel.font.withSize(40)
        todayLabel.addGestureRecognizer(tapGestureRecognizer)
        todayLabel.isUserInteractionEnabled = true
    }
    @objc
    func viewMapTapped(sender: UITapGestureRecognizer) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy. MM. dd."
        let myDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            myDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //           myDatePicker.timeZone = .current
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 272, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: "", preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let time = dateformatter.string(from: myDatePicker.date)
            self.changedDate = myDatePicker.date
            self.todayLabel.text = time
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: self.changedDate)
            let date2 = calendar.startOfDay(for: self.selectedDate)
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            self.dDay = components.day ?? 0
            self.resultTextField.text = "\(-(self.dDay))"
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    @objc
    func CalculateDday(_ sender: UIButton) {
        let textFieldNum = Int(resultTextField.text ?? "") ?? 0
        let day = Date(timeInterval: TimeInterval(textFieldNum * 86400), since: selectedDate)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy. MM. dd."
        let time = dateformatter.string(from: day)
        changedDate = day
        todayLabel.text = "\(time)"
    }
    
}
