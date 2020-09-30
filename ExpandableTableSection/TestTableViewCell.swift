//
//  TestTableViewCell.swift
//  ExpandableTableSection
//
//  Created by maochun on 2020/9/26.
//

import UIKit


public extension UITableViewCell {
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

class TestTableViewCell: UITableViewCell {
    
    
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Helvetica", size: 16)
        label.textColor = UIColor(red: 0x70/255, green: 0x70/255, blue: 0x70/255, alpha: 1)
        label.textAlignment = NSTextAlignment.left

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()


        self.contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
            
        ])
        
        return label
    }()
    
    func setup(name:String){
        self.itemNameLabel.text = name
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
}
