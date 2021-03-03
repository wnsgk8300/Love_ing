//
//  DayTableViewCell.swift
//  Love
//
//  Created by JEON JUNHA on 2021/02/27.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI() {
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15)
        ])
    }
}
