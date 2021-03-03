//
//  DayTableViewCell.swift
//  Love
//
//  Created by JEON JUNHA on 2021/02/27.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    let dayLabel = UILabel()
    let dateLabel = UILabel()
    let dDayLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI() {
        [dayLabel, dateLabel, dDayLabel].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 140),
            
            dDayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dDayLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dDayLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
