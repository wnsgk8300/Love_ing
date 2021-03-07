//
//  ViewController.swift
//  DatePicker
//
//  Created by 신민희 on 2021/02/24.
//

import UIKit
import MobileCoreServices
import Photos


class ViewController: UIViewController {
    
    var value = 0
    
    let datePicker = UIDatePicker()
    let dateLabel = UILabel()
    let headLabel = UILabel()
    let backLabel = UILabel()
    let dayLabel = UILabel()
    let person1 = UILabel()
    let person2 = UILabel()
    let DdayLabel = UILabel()
    let PhotoImage = UIImageView()
    let imagePickerController = UIImagePickerController()
    let person1Btn = UIButton()
    let person2Btn = UIButton()
    var flagImageSave = true
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    var gradientLayer: CAGradientLayer!
    let firstView = UIView()
    let circleView = UIView()
    let viewButton = UIButton()
    let viewLabel = UILabel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer .frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor, UIColor.white.cgColor]
        self.view.layer.addSublayer(self.gradientLayer)
        
        navigationController?.navigationBar.topItem?.title = "D-day"
        let barbutton = UIBarButtonItem(image: (UIImage(systemName: "gearshape")), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleBarButton(_:)))
        navigationItem.rightBarButtonItem = barbutton
        
        imagePickerController.delegate = self
        setLayout()
        setDate()
        setFirstView()
        
    }
    
    func setFirstView() {
        
        [firstView, viewButton, viewLabel, circleView].forEach { (view) in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        firstView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            circleView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: -40),
            circleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 80),
            circleView.heightAnchor.constraint(equalToConstant: 80),
            
            firstView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            firstView.widthAnchor.constraint(equalToConstant: 300),
            firstView.heightAnchor.constraint(equalToConstant: 300),
            
            viewButton.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            viewButton.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: 80),
            viewButton.widthAnchor.constraint(equalToConstant: 100),
            viewButton.heightAnchor.constraint(equalToConstant: 30),
            
            viewLabel.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            viewLabel.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: -80),
            
            datePicker.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor),
        ])
        
        
        viewButton.backgroundColor = .lightGray
        viewButton.addTarget(self, action: #selector(closeButton(_:)), for: .touchUpInside)
        viewButton.setTitle("확인", for: .normal)
        viewButton.setTitleColor(.black, for: .normal)
        viewButton.layer.cornerRadius = 10
        
        firstView.layer.cornerRadius = 30
        firstView.backgroundColor = .white
        firstView.alpha = 1
        
        //        이미지 적용 안 됨ㅇ
        //        let image = UIImage(named: "pencil.circle")
        //        let iv1 = UIImageView(image: image)
        //        circleView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        //        circleView.addSubview(iv1)
        circleView.layer.cornerRadius = 40
        circleView.backgroundColor = .systemPink
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.layer.borderWidth = 3
        
        viewLabel.text = "기념일을 입력해 주세요"
        viewLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        viewLabel.textColor = .darkGray
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .automatic
        }
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    func setLayout() {
        [dateLabel, person1Btn, person2Btn, DdayLabel, person1, person2, headLabel, backLabel, dayLabel, PhotoImage].forEach { (view) in
            self.view.addSubview(view)
            view.alpha = 0
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate ([
            
            
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            headLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 40),
            headLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 80),
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 20),
            backLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            person1Btn.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 200),
            person1Btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            person1Btn.heightAnchor.constraint(equalToConstant: 120),
            person1Btn.widthAnchor.constraint(equalToConstant: 120),
            
            person2Btn.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 200),
            person2Btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            person2Btn.heightAnchor.constraint(equalToConstant: 120),
            person2Btn.widthAnchor.constraint(equalToConstant: 120),
            
            person1.topAnchor.constraint(equalTo: person1Btn.bottomAnchor, constant: 20),
            person1.centerXAnchor.constraint(equalTo: person1Btn.centerXAnchor),
            
            person2.topAnchor.constraint(equalTo: person2Btn.bottomAnchor, constant: 20),
            person2.centerXAnchor.constraint(equalTo: person2Btn.centerXAnchor),
            
            DdayLabel.topAnchor.constraint(equalTo: person1.bottomAnchor, constant: 30),
            DdayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            PhotoImage.topAnchor.constraint(equalTo: DdayLabel.bottomAnchor, constant: 10),
            PhotoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PhotoImage.heightAnchor.constraint(equalToConstant: 120),
            PhotoImage.widthAnchor.constraint(equalToConstant: 120)
            
        ])
        
    }
    
    
    func setDate() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: 40)
        dateLabel.textColor = .white
        dateLabel.text = "♡ 0000-00-00 ♡"
        dateLabel.sizeToFit()
        dateLabel.isUserInteractionEnabled = true
        dateLabel.addGestureRecognizer(tapGesture)
        
        PhotoImage.backgroundColor = .white
        PhotoImage.layer.cornerRadius = 60
        
        DdayLabel.text = "♡ - 0"
        DdayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        DdayLabel.textColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        headLabel.text = "코딩한지"
        headLabel.font = UIFont.boldSystemFont(ofSize: 0)
        headLabel.textColor = .white
        headLabel.addGestureRecognizer(tapGestureRecognizer)
        headLabel.isUserInteractionEnabled = true
        
        
        backLabel.text = "되었습니다."
        backLabel.font = UIFont.boldSystemFont(ofSize: 0)
        backLabel.textColor = .white
        
        dayLabel.text = "0 일"
        dayLabel.font = UIFont.boldSystemFont(ofSize: 30)
        dayLabel.textColor = .lightGray
        
        person1Btn.backgroundColor = .lightGray
        person1Btn.addTarget(self, action: #selector(album(_:)), for: .touchUpInside)
        person1Btn.layer.cornerRadius = 60
        person1Btn.tag = 1
        person1Btn.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
        
        person2Btn.backgroundColor = .lightGray
        person2Btn.addTarget(self, action: #selector(camera(_:)), for: .touchUpInside)
        person2Btn.layer.cornerRadius = 60
        person2Btn.tag = 2
        person2Btn.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        
        let tapGestureRecognizerPerson1 = UITapGestureRecognizer(target: self, action: #selector(FirstPersonTapped))
        tapGestureRecognizerPerson1.numberOfTouchesRequired = 1
        tapGestureRecognizerPerson1.numberOfTapsRequired = 1
        
        person1.text = "사람1"
        person1.font = UIFont.boldSystemFont(ofSize: 25)
        person1.textColor = .white
        person1.addGestureRecognizer(tapGestureRecognizerPerson1)
        person1.isUserInteractionEnabled = true
        
        let tapGestureRecognizerPerson2 = UITapGestureRecognizer(target: self, action: #selector(secondPersonTapped))
        tapGestureRecognizerPerson2.numberOfTouchesRequired = 1
        tapGestureRecognizerPerson2.numberOfTapsRequired = 1
        
        person2.text = "사람2"
        person2.font = UIFont.boldSystemFont(ofSize: 25)
        person2.textColor = .white
        person2.addGestureRecognizer(tapGestureRecognizerPerson2)
        person2.isUserInteractionEnabled = true
        
    }
    
    
    
    
    
    @objc
    func closeButton(_ sender: UIButton) {
        
        [firstView, viewButton, viewLabel, datePicker, circleView].forEach { (view) in
            view.isHidden = true
        }
        self.datePicker.addTarget(self, action: #selector(self.changed), for: .valueChanged)
        UIView.animate(withDuration: 3) {
            
            [self.dateLabel, self.person1Btn, self.person2Btn, self.DdayLabel, self.person1, self.person2, self.headLabel, self.backLabel, self.dayLabel, self.PhotoImage].forEach { (view) in
                self.view.addSubview(view)
                view.alpha = 1
            }
            self.headLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.headLabel.frame.origin.x -= -90
            self.backLabel.font = UIFont.boldSystemFont(ofSize: 20)
            self.backLabel.frame.origin.x -= +90
            self.dateLabel.font = UIFont.boldSystemFont(ofSize: 40)
            self.dateLabel.frame.origin.y -= -80
        }
        
    }
    
    
    @objc
    func viewMapTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "문구를 변경해 주세요", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = self.headLabel.text
        }
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.headLabel.text = alert.textFields?[0].text
            if alert.textFields?[0].text == "" {
                self.headLabel.text = "코딩한지"
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func FirstPersonTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "문구를 변경해 주세요", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = self.person1.text
        }
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.person1.text = alert.textFields?[0].text
            if alert.textFields?[0].text == "" {
                self.person1.text = "사람1"
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func secondPersonTapped(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "문구를 변경해 주세요", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = self.person2.text
        }
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.person2.text = alert.textFields?[0].text
            if alert.textFields?[0].text == "" {
                self.person2.text = "사람2"
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc
    func handleBarButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .automatic
        }
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
        
    }
    
    var selectedDate = Date()
    let resultTextField = UITextField()
    
    @objc
    func changed(){
        let dateformatter = DateFormatter()
        //        dateformatter.dateStyle = .medium //
        //        dateformatter.timeStyle = .none // 시간 사용시에 변경
        dateformatter.locale = Locale(identifier: "ko") // 로케일 변경
        dateformatter.dateFormat = "♡ yyyy-MM-dd ♡"
        let date = dateformatter.string(from: datePicker.date)
        dateLabel.text = date
        selectedDate = datePicker.date
        
        let calendar = Calendar.current
        let date3 = Date()
        let date1 = calendar.startOfDay(for: date3)
        let date2 = calendar.startOfDay(for: selectedDate)
        
        print("\(date), \(selectedDate)")
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        let dDay = components.day
        dayLabel.text = "\(-(dDay ?? 0)) 일"
        DdayLabel.text = "♡\(-(dDay ?? 0))"
        let dayLeft = (dDay ?? 0) + 100
        if dDay ?? 0 <= 1 {
            DdayLabel.text = "100일까지 \(dayLeft)일 남았습니다."
        }
        
        
    }
    
    func openLibrary(){
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: false, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            // 사진 촬영시 정방형으로 사이즈 자동 맞춤
            imagePickerController.cameraDevice = .rear
            imagePickerController.cameraCaptureMode = .photo
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
            
        }
        else{
            print("Camera not available")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let Image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if value == 1 {
                print("123")
                person1Btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: person1Btn.bounds.width - person1Btn.bounds.height)
                person1Btn.imageView?.layer.cornerRadius = person1Btn.bounds.height/2.0
                person1Btn.setImage(Image, for: .normal)
            } else if value == 2 {
                print("456")
                person2Btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: person2Btn.bounds.width - person2Btn.bounds.height)
                person2Btn.imageView?.layer.cornerRadius = person2Btn.bounds.height/2.0
                person2Btn.setImage(Image, for: .normal)
                
                
            }
            
            picker.dismiss(animated: true) {
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
        }
    }
    
    
    @objc
    func album(_ sender: UIButton) {
        value = 1
        
        let alert =  UIAlertController(title: "이미지를 바꿔주세요", message: "", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func camera(_ sender: UIButton) {
        value = 2
        
        let alert =  UIAlertController(title: "이미지를 바꿔주세요", message: "", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}



// 뷰에 안 올림
//func setAlert() {
//
//    datePicker.datePickerMode = .date
//    if #available(iOS 13.4, *) {
//        datePicker.preferredDatePickerStyle = .automatic
//    } else {
//    }
//    datePicker.frame = CGRect(x: 0, y: 15, width: 272, height: 200)
//    let alertController = UIAlertController(title: "D-Day 설정", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
//    //        alertController.view.addSubview(datePicker)
//    alertController.addTextField { (walletField) in
//        walletField.placeholder = "무슨 날인가요?"
//    }
//
//
//    let action = UIAlertAction(title: "확인", style: .default) { _ in
//        self.datePicker.addTarget(self, action: #selector(self.changed), for: .valueChanged)
//        UIView.animate(withDuration: 3) {
//            self.headLabel.alpha = 1
//            self.headLabel.font = UIFont.boldSystemFont(ofSize: 20)
//            self.headLabel.frame.origin.x -= -90
//            self.backLabel.alpha = 1
//            self.backLabel.font = UIFont.boldSystemFont(ofSize: 20)
//            self.backLabel.frame.origin.x -= +90
//
//        }
//    }
//    alertController.addAction(action)
//    alertController.view.addSubview(datePicker)
//
//    present(alertController, animated: true, completion: nil)
//
//}


//        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
//
//            //        self.imagePickerController.sourceType = .photoLibrary
//            present(self.imagePickerController, animated: true, completion: nil)
//
//        }
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            // 미디어 종류 확인
//            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
//            // 미디어가 사진이면
//            if mediaType.isEqual(to: kUTTypeImage as NSString as String){
//                // 사진을 가져옴
//                let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//
//                if flagImageSave { // flagImageSave가 true일 때
//                    // 사진을 포토 라이브러리에 저장
//                    UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
//                }
//                // 가져온 사진을 해당하는 이미지 뷰에 넣기...
//                if numImage == 1 {
//                    PhotoImage.image = captureImage // 가져온 사진을 이미지 뷰에 출력
//                }
//            }
//            // 현재의 뷰(이미지 피커) 제거
//            self.dismiss(animated: true, completion: nil)
//        }
//    }








//
//func calculateDays() {
//
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let startDate = dateFormatter.date(from: "2020-09-13")
//    daysCount = days(from: startDate ?? currentDate)
//    let hundred = calendar.date(byAdding: .day, value: 100, to: startDate ?? currentDate)
//}
//
//func days(from date: Date) -> Int {
//    return calendar.dateComponents([.day], from: date, to: currentDate).day ?? +1
//
//}

