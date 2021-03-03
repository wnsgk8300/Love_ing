//
//  File.swift
//  LoveIngAPP
//
//  Created by 신민희 on 2021/03/03.
//

import UIKit

class CustomView: UIView {
    
    let firstView = UIView()
    let viewButton = UIButton()
    let viewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
    }
    
    init(view: UIView) {
                    
            [firstView, viewButton, viewLabel].forEach { (view) in
                view.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        
            
            
            NSLayoutConstraint.activate([
                
                firstView.widthAnchor.constraint(equalToConstant: 300),
                firstView.heightAnchor.constraint(equalToConstant: 300),
                
                
                viewButton.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
                viewButton.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: 80),
                viewButton.widthAnchor.constraint(equalToConstant: 100),
                viewButton.heightAnchor.constraint(equalToConstant: 30),
                
                viewLabel.centerXAnchor.constraint(equalTo: self.firstView.centerXAnchor),
                viewLabel.centerYAnchor.constraint(equalTo: self.firstView.centerYAnchor, constant: -80),
                
            ])
        super.init(frame: .zero) // == CGRect(x: 0, y: 0, w: 0, h: 0)
        viewButton.backgroundColor = .lightGray
        viewButton.setTitle("확인", for: .normal)
        viewButton.setTitleColor(.black, for: .normal)
        viewButton.layer.cornerRadius = 10
        
        
        firstView.layer.cornerRadius = 30
        firstView.backgroundColor = .white
        firstView.alpha = 1
        
        viewLabel.text = "기념일을 입력해 주세요"
        viewLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        viewLabel.textColor = .darkGray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
