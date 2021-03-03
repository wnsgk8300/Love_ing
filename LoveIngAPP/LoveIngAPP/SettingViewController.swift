//
//  SettingViewController.swift
//  DatePicker
//
//  Created by 신민희 on 2021/02/27.
//

import UIKit

class SettingViewController: UIViewController {
    
    let data = [
        ["사람1", "사람2"],
        ["위 문구 변경", "아래 문구 변경"],
        ["시작일"]
    ]
    let tableView = UITableView()
    
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer .frame = view.bounds
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
        self.view.layer.addSublayer(gradientLayer)
        
        let CategoryHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        CategoryHeaderView.backgroundColor = .lightGray
        
        let headerLabel = UILabel(frame: CategoryHeaderView.bounds)
        headerLabel.text = "이름"
        headerLabel.textAlignment = .center
        CategoryHeaderView.addSubview(headerLabel)
        tableView.tableHeaderView = CategoryHeaderView

        navigationController?.navigationBar.topItem?.title = "Setting"
        
        setTableView()
        setUI()

    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        tableView.rowHeight = 50
        tableView.separatorInset.right = 20 // 셀 나눠주는 선 끝부분 공백
    }
    
    func setUI() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        let VC = ViewController()
        switch data[indexPath.section][indexPath.row] {
        case "사람1":
            let alert = UIAlertController(title: "이름을 변경해 주세요", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = VC.person1.text
            }
            
            let action = UIAlertAction(title: "확인", style: .default) { _ in
                VC.person1.text = alert.textFields?[0].text
                if alert.textFields?[0].text == "" {
                    VC.person1.text = "사랑한지"
                }
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        default:
            break
        }

    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    } // 섹션 왜 안 나눠짐? ㅡㅡ
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { fatalError() }
        cell.partLabel.text = data[indexPath.section][indexPath.row]
        return cell
    }
    
}
