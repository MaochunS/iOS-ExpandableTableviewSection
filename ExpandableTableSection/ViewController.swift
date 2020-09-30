//
//  ViewController.swift
//  ExpandableTableSection
//
//  Created by maochun on 2020/9/26.
//

import UIKit


class ViewController: UIViewController {
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.isEditing = true
        
        
        self.view.addSubview(tableView)

        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: TestTableViewCell.cellIdentifier())
        tableView.register(TestTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TestTableViewHeader.cellIdentifier())
        
        return tableView
    }()

    var sectionNum = 5;
    var sectionArray = [SectionData]()
    var tableViewReorderImage : UIImage? = nil;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< sectionNum{
            sectionArray.append(SectionData.init(name: "Test Section \(i)", sectionNo: i, numOfItems: 2 + i))
        }
        
        self.theTableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].expanded ? sectionArray[section].itemNameArr.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.cellIdentifier(), for:indexPath)
     
        if let commonCell = cell as? TestTableViewCell{
            commonCell.setup(name: self.sectionArray[indexPath.section].itemNameArr[indexPath.row])
        }
        
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TestTableViewHeader.cellIdentifier())
        if let header = header as? TestTableViewHeader{
            header.setup(name: "Section \(section)")
            header.delegate = self
            header.section = section
         
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for subView in cell.subviews {
            if (subView.classForCoder.description() == "UITableViewCellReorderControl") {
                for subSubView in subView.subviews {
                    if (subSubView.isKind(of: UIImageView.classForCoder())) {
                        let imageView = subSubView as! UIImageView;
                        if (tableViewReorderImage == nil) {
                            let myImage = imageView.image;
                            tableViewReorderImage = myImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate);
                        }
                        imageView.image = tableViewReorderImage;
                        imageView.tintColor = UIColor.red;
                        break;
                    }
                }
                break;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.sectionArray[sourceIndexPath.section].itemNameArr[sourceIndexPath.row]
        self.sectionArray[sourceIndexPath.section].itemNameArr.remove(at: sourceIndexPath.row)
        self.sectionArray[destinationIndexPath.section].itemNameArr.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  
}


extension ViewController: TestTableViewHeaderDelegate{
    func toggleSection(_ header: TestTableViewHeader, section: Int) {
        if section == -1{
            return
        }
        
        self.sectionArray[section].expanded = !self.sectionArray[section].expanded
        
        self.theTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
}
