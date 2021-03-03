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
    var dDay: [String] = []
    let headerLabel = UILabel()
    let datePickerAlertButton = UIButton()
    let dayTextField = UITextField()
    var whatDay = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            self.dDay.append(self.whatDay + time)
            self.dDayTableView.reloadData()
        })
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alertController.addAction(selectAction)
           alertController.addAction(cancelAction)
           present(alertController, animated: true)
    }
    func setMenuTableView() {
    }
//    func setDDayTableView() {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: dDayTableView.frame.width, height: dDayTableView.rowHeight))
//        headerView.backgroundColor = .blue
//        dDayTableView.tableHeaderView = headerView
//        headerView.addSubview(headerLabel)
//        headerLabel.text = "기념일"
//    }
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
        headerLabel.text = "기념일"
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
        if tableView == menuTableView && indexPath.row == 0 {
            let nextVC = CalculateDDayViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension DDayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == menuTableView {
            guard let menuCell = menuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                    as? DayTableViewCell else { fatalError() }
            menuCell.label.text = menu[indexPath.item]
            return menuCell
            
        }
        else {
            guard let dDayCell = menuTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                    as? DayTableViewCell else { fatalError() }
            dDayCell.label.text = dDay[indexPath.item]
            return dDayCell
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return menu.count
        }
        else {
            return dDay.count
        }
    }
    
}
