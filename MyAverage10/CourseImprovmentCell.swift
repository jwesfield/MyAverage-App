//
//  CourseImprovmentCell.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-06.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import UIKit
import ValueStepper

class CourseImprovmentCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var stepper: ValueStepper!
    
    var prevValue = 0.0
    var data : Improvments!
    var current_Course: Course!
    var grade = 0.0
    
    @IBOutlet weak var increaseLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    @IBAction func stepperPressed(_ sender: Any) {
        // sends value and tag to courseImprovmentVC
        if let d = data {
            
            if(stepper.value > prevValue){
                d.updateValues(i_CourseIndex: self.tag, i_IsIncreasing: true)
                
            } else {
                
                d.updateValues(i_CourseIndex: self.tag, i_IsIncreasing: false)
            }
            
            prevValue = stepper.value
            
        }
        if(self.stepper.value > grade){
              self.increaseLabel.text = "+ \(self.stepper.value - grade)"
            self.increaseLabel.textColor = UIColor.green
        } else if (self.stepper.value < grade){
            self.increaseLabel.text = "- \(grade - self.stepper.value)"
            self.increaseLabel.textColor = UIColor.red
        } else{
            self.increaseLabel.text = "\(0)"
            self.increaseLabel.textColor = UIColor.black
        }
      
      
    }
    
    func configureCell (i_Course : Course , i_Data : Improvments){
        self.nameLabel.text = i_Course.Name
        self.gradeLabel.text = "\(i_Course.Grade)"
        self.stepper.value = i_Course.Grade
        self.prevValue = i_Course.Grade
        self.data = i_Data
        self.current_Course = i_Course
        self.grade = i_Course.Grade
        
        self.increaseLabel.text = "\(0)"
        self.increaseLabel.textColor = UIColor.black
    }
}
