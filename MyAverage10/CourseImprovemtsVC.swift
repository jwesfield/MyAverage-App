//
//  CourseImprovemtsVC.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-19.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import UICircularProgressRing

var AllSemestersCopy = [Semester]()

class CourseImprovemtsVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    /** IBOutlets **/
    
    @IBOutlet weak var semesterImprovmentLabel: UILabel!
    @IBOutlet weak var yearImprovmentLabel: UILabel!
    @IBOutlet weak var totalImprovmentLabel: UILabel!
    
    @IBOutlet weak var totalAverageCircle: UICircularProgressRingView!
    @IBOutlet weak var yearAverageCircle: UICircularProgressRingView!
    @IBOutlet weak var semesterAverageCircle: UICircularProgressRingView!
    
    @IBOutlet weak var tableView: UITableView!
    
    /** Data Members **/
    
    private var selectedCourses = [Course]()
    private var ImprovmentData : Improvments!
    
    /** Constructor **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        for i in check_data_array {
            if(i.isChecked == true){
                selectedCourses.append(i.course)
            }
        }
        
        if(selectedCourses.count < 1){
            let alert1 = UIAlertController(title: "No Courses Selected", message: "Please go back and select courses to improve.", preferredStyle: .alert)
            
            alert1.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert1, animated: true, completion: nil)
            return
        }
        
        self.ImprovmentData = Improvments(i_courses: self.selectedCourses)
        
        if(ImprovmentData.IsOneSemester == true){
            self.semesterAverageCircle.value = CGFloat(ImprovmentData.NewSemAverage)
            
        } else {
            self.semesterAverageCircle.isHidden = true
            self.semesterImprovmentLabel.isHidden = true
        }
        if(ImprovmentData.IsOneYear == true){
            self.yearAverageCircle.value = CGFloat(ImprovmentData.NewYearAverage)
        } else {
            self.yearAverageCircle.isHidden = true
            self.yearImprovmentLabel.isHidden = true
        }
        
        self.totalAverageCircle.value = CGFloat(ImprovmentData.NewTotalAverage)
    }
    
     /** Class Logic **/
    
    @IBAction func CourseStepperPressed(_ sender: Any) {
        
        
        if(ImprovmentData.IsOneSemester == true){
            self.semesterAverageCircle.value = CGFloat(ImprovmentData.NewSemAverage)
            
            
            if(ImprovmentData.SemesterImprovment == 0.0){
                self.semesterImprovmentLabel.textColor = UIColor.black
                self.semesterImprovmentLabel.text = "\(ImprovmentData.SemesterImprovment.roundToDecimal(1))"
            } else if(ImprovmentData.isIncreasingSemester){
                
                self.semesterImprovmentLabel.textColor = UIColor.green
                
                
                self.semesterImprovmentLabel.text = "+ \(ImprovmentData.SemesterImprovment.roundToDecimal(1))"
            } else {
                self.semesterImprovmentLabel.textColor = UIColor.red
                self.semesterImprovmentLabel.text = "- \(ImprovmentData.SemesterImprovment.roundToDecimal(1))"
            }
            
        }
        if(ImprovmentData.IsOneYear == true){
            self.yearAverageCircle.value = CGFloat(ImprovmentData.NewYearAverage + 0)
            
            if(ImprovmentData.YearImprovment == 0.0){
                self.yearImprovmentLabel.textColor = UIColor.black
                self.yearImprovmentLabel.text = "\(ImprovmentData.YearImprovment.roundToDecimal(1))"
                
            } else if(ImprovmentData.isIncreasingYear){
                self.yearImprovmentLabel.textColor = UIColor.green
                self.yearImprovmentLabel.text = "+ \(ImprovmentData.YearImprovment.roundToDecimal(1))"
            } else {
                self.yearImprovmentLabel.textColor = UIColor.red
                self.yearImprovmentLabel.text = "- \(ImprovmentData.YearImprovment.roundToDecimal(1))"
            }
        }
        self.totalAverageCircle.value = CGFloat(ImprovmentData.NewTotalAverage + 0)
        
        if(ImprovmentData.TotalImprovment == 0.0){
            self.totalImprovmentLabel.textColor = UIColor.black
            self.totalImprovmentLabel.text = "\(ImprovmentData.TotalImprovment.roundToDecimal(1))"
        } else if(ImprovmentData.isIncreasingTotal){
            self.totalImprovmentLabel.textColor = UIColor.green
            self.totalImprovmentLabel.text = "+ \(ImprovmentData.TotalImprovment.roundToDecimal(1))"
        } else {
            self.totalImprovmentLabel.textColor = UIColor.red
            self.totalImprovmentLabel.text = "- \(ImprovmentData.TotalImprovment.roundToDecimal(1))"
        }
    }
    
    
    /*** Table View ***/

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseImprovmentCell", for: indexPath) as? CourseImprovmentCell {
            
            let currentCourse =  selectedCourses[indexPath.row]
            
            cell.configureCell(i_Course: currentCourse  , i_Data: ImprovmentData )
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }

}
