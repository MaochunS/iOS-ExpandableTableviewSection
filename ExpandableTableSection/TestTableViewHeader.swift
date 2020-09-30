//
//  TestTableViewHeader.swift
//  ExpandableTableSection
//
//  Created by maochun on 2020/9/26.
//

import UIKit

public extension UITableViewHeaderFooterView {
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

protocol TestTableViewHeaderDelegate {
    func toggleSection(_ header: TestTableViewHeader, section: Int)
}

class TestTableViewHeader: UITableViewHeaderFooterView {
    
    lazy var itemNameLabel : UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10" //"\(row+1)"

        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        //label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.init(name: "Helvetica", size: 16)
        label.textColor = .white
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
    
    var delegate : TestTableViewHeaderDelegate?
    var section = -1;
    
    func setup(name:String){
        self.itemNameLabel.text = name
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeader(_:))))
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeHeader(_:)))
        leftSwipe.direction = .left
        addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeHeader(_:)))
        rightSwipe.direction = .right
        addGestureRecognizer(rightSwipe)
        
        
        self.contentView.backgroundColor = .blue
    }
    
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? TestTableViewHeader else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
    
    @objc func rightSwipeHeader(_ gestureRecognizer: UISwipeGestureRecognizer){
        var frame = self.frame
        
        if frame.origin.x != 0{
            frame.origin.x = 0
            UIView.animate(withDuration: 0.2) {
                self.frame = frame
            }
        }
        
    }
    
    @objc func leftSwipeHeader(_ gestureRecognizer: UISwipeGestureRecognizer){
        var frame = self.frame
        
        if frame.origin.x == 0{
            frame.origin.x -= 100
            UIView.animate(withDuration: 0.2) {
                self.frame = frame
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        
    }
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
       
    }
    
    
}
