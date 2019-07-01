//
//  ChooseCoursesVC.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-19.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit


struct courseCheck {
    var isChecked : Bool
    var course : Course
    var index : Int
    
    mutating func setState (state : Bool){
        self.isChecked = state
    }
}

func getCourseCheck (course : Course) -> courseCheck {
    for i in check_data_array {
        //name might not be good enough
        if(i.course.Name ==  course.Name){
            return i
        }
    }
    return check_data_array[0]
}

var check_data_array = [courseCheck]()





class ChooseCoursesVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
     /** IBOutlets **/
    
    @IBOutlet weak var yearSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    /** DataMembers **/
    
    private var currentCourses = [courseCheck]()
    
    /** Constructor **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllSemestersCopy()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        check_data_array.removeAll()
         var index = 0
        for i in all_semesters {
            for j in i.Courses{
                check_data_array.append(courseCheck(isChecked: false, course: j, index: index))
                index += 1
            }
        }
        
        currentCourses = check_data_array
    }
    
    
    
    public func setUpAllSemestersCopy(){
        AllSemestersCopy.removeAll()
        for i in all_semesters{
                      
            let semsterCopy = Semester(i_semester: i.SemesterLetter, i_average: i.Average, i_credits: i.Credits, i_year: i.Year)
            for j in i.Courses {
                let courseCopy = Course(i_Name: j.Name, i_Grade: j.Grade, i_Credits: j.Credits, i_Year: j.Year, i_Parent: j.ParentSemester, i_CountTowardsGPA: j.CountTowardsGPA)
                semsterCopy.AddCourse(i_course: courseCopy)
            }
            AllSemestersCopy.append(semsterCopy)
        }
    }

    
    /** Class Logic **/
    
    @IBAction func yearSegmentPressed(_ sender: Any) {
        
        self.currentCourses.removeAll()
        if(self.yearSegment.selectedSegmentIndex == 0){
            self.currentCourses = check_data_array
            tableView.reloadData()
        } else {
            let currentYear = self.yearSegment.selectedSegmentIndex
            for i in check_data_array {
                if(i.course.Year == currentYear){
                    self.currentCourses.append(i)
                }
            }
        }
        
         tableView.reloadData()
    }
    
    
    /*** Table View ***/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCheckCell", for: indexPath) as? CourseCheckCell {
            
            let course = currentCourses[indexPath.row]
            cell.configureCell(NewClass: course)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
