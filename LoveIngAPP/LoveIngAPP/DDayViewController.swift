//
//  DDayViewController.swift
//  LoveIngAPP
//
//  Created by JEON JUNHA on 2021/03/02.
//

import UIKit

class DDayViewController: UIViewController {
    
    let menuTableView = UITableView()
    let menu = ["날짜 계산", "테마"]
    let dDayTableView = UITableView()
    var dayArr: [String] = []
    var dateArr: [String] = []
    var dDayArr: [String] = []
    let headerLabel = UILabel()
    let datePickerAlertButton = UIButton()
    let dayTextField = UITextField()
    var whatDay = String()
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer .frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
        self.view.layer.addSublayer(self.gradientLayer)

        setMenuTableView()
        setUI()
    }
    @objc
    func datePickerAlert() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy. MM. dd."
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            myDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //           myDatePicker.timeZone = .current
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 272, height: 200)
        let alertController = UIAlertController(title: "D-Day 설정", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        alertController.addTextField { (walletField) in
            walletField.placeholder = "무슨 날인가요?"
        }
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let time = dateformatter.string(from: myDatePicker.date)
            let msg = alertController.textFields?[0].text ?? ""
            
            var selectedDate = Date()
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            selectedDate = myDatePicker.date
            let calendar = Calendar.current
            let date3 = Date()
            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: date3)
            let date2 = calendar.startOfDay(for: selectedDate)
            let components = calendar.dateComponents([.day], from: date1, to: date2)
            let dDay = components.day
            
            self.dDayArr.append(String(describing: -(dDay ?? 0)))
            self.dayArr.append(msg)
            self.dateArr.append(time)
            self.dDayTableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    func setMenuTableView() {
    }
    func setUI() {
        [menuTableView, dDayTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            $0.dataSource = self
            //회색 줄 없애기
            $0.separatorStyle = UITableViewCell.SeparatorStyle.none
            $0.register(DayTableViewCell.self, forCellReuseIdentifier: "Cell")
        }
        [headerLabel, datePickerAlertButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        headerLabel.backgroundColor = .lightGray
        headerLabel.text = "    기념일                                                           D-Day"
        datePickerAlertButton.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        datePickerAlertButton.addTarget(self, action: #selector(datePickerAlert), for: .touchUpInside)
        
        menuTableView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableView.heightAnchor.constraint(equalToConstant: 88),
            
            headerLabel.topAnchor.constraint(equalTo: menuTableView.bottomAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 28),
            
            dDayTableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            dDayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dDayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dDayTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            datePickerAlertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            datePickerAlertButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            datePickerAlertButton.widthAnchor.constraint(equalToConstant: 96),
            datePickerAlertButton.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
}

extension DDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        if tableView == menuTableView && indexPath.row == 0 {
            let nextVC = CalculateDDayViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
        if tableView == dDayTableView {
            vc.dayLabel.text = "3"
        }
    }
}

extension DDayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == dDayTableView {
            return true
        } else { return false }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            dayArr.remove(at: indexPath.row)
            dateArr.remove(at: indexPath.row)
            dDayArr.remove(at: indexPath.row)
            dDayTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == menuTableView {
            guard let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                    as? DayTableViewCell else { fatalError() }
            menuCell.dateLabel.text = menu[indexPath.item]
            return menuCell
            
        }
        else {
            guard let dDayCell = menuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                    as? DayTableViewCell else { fatalError() }
            dDayCell.dateLabel.text = dateArr[indexPath.item]
            dDayCell.dayLabel.text = dayArr[indexPath.item]
            dDayCell.dDayLabel.text = dDayArr[indexPath.item]
            return dDayCell
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return menu.count
        }
        else {
            return dayArr.count
        }
    }
    
}
