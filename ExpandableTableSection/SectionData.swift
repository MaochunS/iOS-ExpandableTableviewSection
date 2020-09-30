//
//  SectionData.swift
//  ExpandableTableSection
//
//  Created by maochun on 2020/9/26.
//

import Foundation

class SectionData{
    
    var expanded = false
    var name = ""
    
    var itemNameArr = [String]()
    
    init(name:String, sectionNo:Int, numOfItems:Int) {
        self.name = name
        self.expanded = false
        
        for i in 0 ..< numOfItems{
            itemNameArr.append("Test item \(sectionNo) \(i)")
        }
    }
}
