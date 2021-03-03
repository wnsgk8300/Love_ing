//
//  ViewController.swift
//  DatePicker
//
//  Created by 신민희 on 2021/02/24.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController {
    
    let datePicker = UIDatePicker()
    let dateLabel = UILabel()
    let headLabel = UILabel()
    let backLabel = UILabel()
    let dayLabel = UILabel()
    let person1 = UILabel()
    let person2 = UILabel()
    let Dday = UILabel()
    let PhotoImage = UIImageView()
    var numImage = 1
    let imagePickerController = UIImagePickerController()
    let cameraBtn = UIButton()
    let albumBtn = UIButton()
    var flagImageSave = true
    var newMeida: Bool?
    let day: Int? = 0
    let calendar = Calendar.current
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    var daysCount:Int = 0
    var date: Int? = 0
    var gradientLayer: CAGradientLayer!
//    let firstView = UIView()
//    let viewButton = UIButton()
//    
//    func setFirstView() {
//        [firstView, viewButton].forEach { (view) in
//            self.view.addSubview(view)
//            view.translatesAutoresizingMaskIntoConstraints = false
//        }
//    }
 
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setAlert()

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
        
    }

    
    func setAlert() {
        
//        if #available(iOS 14, *) {
//            datePicker.preferredDatePickerStyle = .automatic
//        }
//        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(changed), for: .valueChanged)
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        let myDatePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .automatic
        } else {
        }
        datePicker.frame = CGRect(x: 0, y: 15, width: 272, height: 200)
        let alertController = UIAlertController(title: "D-Day 설정", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
//        alertController.view.addSubview(datePicker)
        alertController.addTextField { (walletField) in
            walletField.placeholder = "무슨 날인가요?"
        }
//
//        let alert = UIAlertController(title: "D-day", message: "기념일을 입력해 주세요", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.datePicker.addTarget(self, action: #selector(self.changed), for: .valueChanged)
            UIView.animate(withDuration: 3) {
                self.headLabel.alpha = 1
                self.headLabel.font = UIFont.boldSystemFont(ofSize: 20)
                self.headLabel.frame.origin.x -= -90
                self.backLabel.alpha = 1
                self.backLabel.font = UIFont.boldSystemFont(ofSize: 20)
                self.backLabel.frame.origin.x -= +90
                
            }
        }
        alertController.addAction(action)
        alertController.view.addSubview(datePicker)
        
//        let height: NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
//        alertController.view.addConstraint(height)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    func setLayout() {
        [dateLabel, datePicker, cameraBtn, albumBtn, Dday, person1, person2, headLabel, backLabel, dayLabel, PhotoImage].forEach { (view) in
            self.view.addSubview(view)
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
            
            cameraBtn.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 200),
            cameraBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cameraBtn.heightAnchor.constraint(equalToConstant: 120),
            cameraBtn.widthAnchor.constraint(equalToConstant: 120),
            
            albumBtn.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 200),
            albumBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            albumBtn.heightAnchor.constraint(equalToConstant: 120),
            albumBtn.widthAnchor.constraint(equalToConstant: 120),
            
            person1.topAnchor.constraint(equalTo: cameraBtn.bottomAnchor, constant: 20),
            person1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            
            person2.topAnchor.constraint(equalTo: albumBtn.bottomAnchor, constant: 20),
            person2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            Dday.topAnchor.constraint(equalTo: person1.bottomAnchor, constant: 30),
            Dday.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            PhotoImage.topAnchor.constraint(equalTo: Dday.bottomAnchor, constant: 10),
            PhotoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PhotoImage.heightAnchor.constraint(equalToConstant: 100),
            PhotoImage.widthAnchor.constraint(equalToConstant: 100)

            
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
        
        Dday.text = "D - 0"
        Dday.font = UIFont.boldSystemFont(ofSize: 30)
        Dday.textColor = .white
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewMapTapped))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        
        headLabel.text = "사랑한지"
        headLabel.font = UIFont.boldSystemFont(ofSize: 0)
        headLabel.textColor = .white
        headLabel.alpha = 0
        headLabel.addGestureRecognizer(tapGestureRecognizer)
        headLabel.isUserInteractionEnabled = true
        
        
        backLabel.text = "되었습니다."
        backLabel.font = UIFont.boldSystemFont(ofSize: 0)
        backLabel.textColor = .white
        backLabel.alpha = 0
        
        dayLabel.text = "0 일"
        dayLabel.font = UIFont.boldSystemFont(ofSize: 30)
        dayLabel.textColor = .lightGray
        
        cameraBtn.backgroundColor = .lightGray
        cameraBtn.addTarget(self, action: #selector(album(_:)), for: .touchUpInside)
        cameraBtn.layer.cornerRadius = 60
        cameraBtn.setImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
        
        albumBtn.backgroundColor = .lightGray
        albumBtn.addTarget(self, action: #selector(album(_:)), for: .touchUpInside)
        albumBtn.layer.cornerRadius = 60
        albumBtn.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus"), for: .normal)
        
        person1.text = " 사람 1 "
        person1.font = UIFont.boldSystemFont(ofSize: 25)
        person1.textColor = .white
        
        person2.text = " 사람 2 "
        person2.font = UIFont.boldSystemFont(ofSize: 25)
        person2.textColor = .white
        
        
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
                self.headLabel.text = "사랑한지"
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
    
    
    
    @objc
    func changed(){
        let dateformatter = DateFormatter()
        //        dateformatter.dateStyle = .medium //
        //        dateformatter.timeStyle = .none // 시간 사용시에 변경
        dateformatter.locale = Locale(identifier: "ko") // 로케일 변경
        dateformatter.dateFormat = "♡ yyyy-MM-dd ♡"
        let date = dateformatter.string(from: datePicker.date)
        dateLabel.text = date
    }
    
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    func openLibrary(){
        imagePickerController.sourceType = .photoLibrary
      present(imagePickerController, animated: false, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }

    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
          if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
              PhotoImage.image = image
                  print(info)
              }
              dismiss(animated: true, completion: nil)
          }


    
    @objc
    func album(_ sender: UIButton) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)

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
    
    
}





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

