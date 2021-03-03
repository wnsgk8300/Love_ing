//
//  SettingTableViewCell.swift
//  DatePicker
//
//  Created by 신민희 on 2021/02/27.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    let partLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setPart()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPart() {
        self.contentView.addSubview(partLabel)
        partLabel.textColor = .gray
        partLabel.textAlignment = .left
        partLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        partLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            partLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            partLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
}
