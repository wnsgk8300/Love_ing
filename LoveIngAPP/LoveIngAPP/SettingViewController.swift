//
//  SettingViewController.swift
//  DatePicker
//
//  Created by 신민희 on 2021/02/27.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    let data = [
        ["사람1", "사람2"],
        ["위 문구 변경", "아래 문구 변경"],
        ["시작일"]
    ]
    let tableView = UITableView()
    var gradientLayer: CAGradientLayer!
    let firstView = UIView()
    let circleView = UIView()
    let viewButton = UIButton()
    let viewLabel = UILabel()
    let viewTextField = UITextField()
    let limitLength = 10
    weak var delegate: SettingViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
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
        viewTextField.delegate = self
        
        
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        print(text.count, string.count, range.length)
        return newLength <= limitLength
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.deselectRow(at: indexPath, animated: true)
        let VC = ViewController()
        [firstView, viewButton, viewLabel, circleView, viewTextField].forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            
            firstView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            firstView.widthAnchor.constraint(equalToConstant: 240),
            firstView.heightAnchor.constraint(equalToConstant: 240),
            
            circleView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: -40),
            circleView.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            
            viewButton.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            viewButton.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: 80),
            viewButton.widthAnchor.constraint(equalToConstant: 100),
            viewButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewLabel.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: -70),
            
            viewTextField.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            viewTextField.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor),
            viewTextField.widthAnchor.constraint(equalToConstant: 200)
            
        ])
        
       
        
        firstView.layer.cornerRadius = 30
        firstView.backgroundColor = .white
        firstView.alpha = 1
        
        circleView.layer.cornerRadius = 35
        circleView.backgroundColor = .systemPink
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 3
        
        viewLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        viewLabel.textColor = .darkGray
        
        
        
        
        viewButton.backgroundColor = .lightGray
        viewButton.setTitle("확인", for: .normal)
        viewButton.setTitleColor(.black, for: .normal)
        viewButton.layer.cornerRadius = 10
        
        if tableView == self.tableView && indexPath.row == 0 {
            viewLabel.text = "사람1을 변경해 주세요"
            viewTextField.placeholder = VC.person1.text
            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        } else if tableView == self.tableView && indexPath.row == 1 {
            viewTextField.placeholder = VC.person2.text
            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        }
        
//        switch data[indexPath.section][indexPath.row] {
//
//        case "사람1":
//            viewLabel.text = "사람1을 변경해 주세요"
//            viewTextField.placeholder = VC.person1.text
//            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
//
//        case "사람2":
//            viewTextField.placeholder = VC.person2.text
//            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
//
//        case "위 문구 변경":
//            viewLabel.text = "위 문구를 변경해 주세요"
//            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
//
//
//        case "아래 문구 변경":
//            viewLabel.text = "아래 문구를 변경해 주세요"
//            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
//
//
//        case "시작일":
//            viewLabel.text = "시작일을 변경해 주세요"
//            viewButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
//
//
//
//
//        default:
//            break
//        }
        
        }
    
    @objc
    func handleButton(_ sender: UIButton) {
        
        [firstView, viewButton, viewLabel,viewTextField, circleView].forEach { (view) in
            view.isHidden = true
        }
        guard let text = viewTextField.text else {return}
        viewTextField.delegate = self
        self.delegate?.textFieldInput(text: "abcd")
        
        //        let VC = ViewController()
        //        VC.person1.text = viewTextField.text
        //        dismiss(animated: true, completion: nil)
        
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


protocol SettingViewControllerDelegate: class {
    func textFieldInput(text:String) //여기서 함수 구현 못한다 채택에서 해줘야됨
}


