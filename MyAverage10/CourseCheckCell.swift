//
//  CourseCheckCell.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-06.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import UIKit
import M13Checkbox

class CourseCheckCell: UITableViewCell {


    @IBOutlet weak var checkBox: M13Checkbox!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    private var current_di : courseCheck!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    @IBAction func boxChecked(_ sender: Any) {
        if (checkBox.checkState == .checked){
            check_data_array[current_di.index].setState(state: true)
            for i in check_data_array{
                print(i.course.Name)
            }
            
        } else if(checkBox.checkState == .unchecked){
             check_data_array[current_di.index].setState(state: false)
        }
    }
    

    func configureCell(NewClass: courseCheck){
        current_di = NewClass
     
        if(NewClass.isChecked){
            self.checkBox.checkState = .checked
        } else {
            self.checkBox.checkState = .unchecked
        }
        
        self.checkBox.stateChangeAnimation = .expand(.fill)
        
        self.nameLabel.text = "\(NewClass.course.Name)"
        self.gradeLabel.text = "Grade : \(NewClass.course.Grade)"
    }
}
