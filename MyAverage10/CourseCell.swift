//
//  CourseCell.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-06.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CourseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeRing: UICircularProgressRingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell (i_Course : Course){
        
        nameLabel.text = i_Course.Name
        gradeLabel.text = "Grade : \(i_Course.Grade)"
        creditsLabel.text = "Credits : \(i_Course.Credits)"
        gradeRing.value = CGFloat(i_Course.Grade)
        
    }

}
