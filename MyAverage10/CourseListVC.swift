//
//  CourseListVC.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-19.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit




class CourseListVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate  {
    

    /** IBOutlets **/
    
    @IBOutlet weak var SemesterNameLabel: UILabel!
    @IBOutlet weak var SemesterAverageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    /** New Course **/
    
    @IBOutlet var newCourseView: UIViewX!
    @IBOutlet weak var nameField: UITextFieldX!
    @IBOutlet weak var creditsField: UITextFieldX!
    @IBOutlet weak var gradeField: UITextFieldX!
    @IBOutlet weak var CourseViewTopLabel: UILabel!
    
    
     /** Data Members **/
    
    public var CurrentSemester : Semester!
    public var CurrentSemesterIndex : Int!
    private var selectedCourseToEditIndex : Int!
    private var isEditingCourse = false
    private var selectedCourseToEdit : Course!
    
    
      /** Constructor **/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.nameField.delegate = self
        self.gradeField.delegate = self
        self.creditsField.delegate = self
        
        self.SemesterNameLabel.text = "Year \(CurrentSemester.Year) / Semester \(CurrentSemester.SemesterLetter)"
        self.SemesterAverageLabel.text = "Average : \(CurrentSemester.Average.roundToDecimal(1))%"
        
    }
    
    
    @IBAction func newCourseButtonPressed(_ sender: Any) {
        
        self.CourseViewTopLabel.text = "Add New Course"
        self.nameField.text = ""
        self.gradeField.text = ""
        self.creditsField.text = ""
        self.AddViews()
    }
   
    
     /*** New Course View Functions ***/
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        var inputName = ""
        var inputCredits = 0.0
        var inputGrade = 0.0
        
        if let currentName = self.nameField.text, nameField.text != "" {
            
            inputName = currentName;
            
            if let currentGradeString = self.gradeField.text{
                if let currentGradeNumber = Double(currentGradeString){
                    inputGrade = currentGradeNumber
                } else {
                    self.present(self.getAlert(i_alertNumber: 2), animated: true, completion: nil)
                    return
                }
            } else {
                self.present(self.getAlert(i_alertNumber: 2), animated: true, completion: nil)
                return
            }
            
            if let currentCreditsString = self.creditsField.text{
                if let currentCreditsNumber = Double(currentCreditsString){
                    inputCredits = currentCreditsNumber
                } else {
                    self.present(self.getAlert(i_alertNumber: 3), animated: true, completion: nil)
                    return
                }
            } else {
                self.present(self.getAlert(i_alertNumber: 3), animated: true, completion: nil)
                return
            }
            
        } else {
            self.present(self.getAlert(i_alertNumber: 1), animated: true, completion: nil)
            return
        }
        
        
        if(isEditingCourse == false ){
            let newCourse = Course(i_Name: inputName, i_Grade: inputGrade, i_Credits: inputCredits, i_Year: self.CurrentSemester.Year, i_Parent: CurrentSemester, i_CountTowardsGPA: true) // 
            
            
            //FIX
            
            self.CurrentSemester.AddCourse(i_course: newCourse)
            UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            tableView.reloadData()
        } else {
            self.selectedCourseToEdit.Name = inputName
            self.selectedCourseToEdit.Grade = inputGrade
            self.selectedCourseToEdit.Credits = inputCredits
           
            all_semesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Grade = inputGrade
            all_semesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Name = inputName
            all_semesters[CurrentSemesterIndex].Courses[selectedCourseToEditIndex].Credits = inputCredits
             UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            isEditingCourse = false
            
            for i in all_semesters{
                for j in i.Courses{
                    print("\(j.Name) ,  \(j.Grade)")
                   
                }
            }
            
            tableView.reloadData()
        }
        self.CurrentSemester.CalculateSemesterAverage()
        all_semesters[CurrentSemesterIndex].CalculateSemesterAverage()
        self.SemesterAverageLabel.text = "Average : \(CurrentSemester.Average.roundToDecimal(1))%"
        tableView.reloadData()
        newCourseView.removeFromSuperview()
        tempView.removeFromSuperview()
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        newCourseView.removeFromSuperview()
        tempView.removeFromSuperview()
    }
    
    
    /*** Table View ***/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.CurrentSemester.Courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as? CourseCell {
            
            let currentCourse = self.CurrentSemester.Courses[indexPath.row]
            cell.configureCell(i_Course: currentCourse)
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCourseToEdit = self.CurrentSemester.Courses[indexPath.row]
        self.selectedCourseToEditIndex = indexPath.row
        self.isEditingCourse = true
        self.CourseViewTopLabel.text = "Course Info"
        self.nameField.text = selectedCourseToEdit.Name
        self.gradeField.text = "\(selectedCourseToEdit.Grade)"
        self.creditsField.text = "\(selectedCourseToEdit.Credits)"
        self.AddViews()
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.CurrentSemester.RemoveCourse(i_index: indexPath.row)
            CurrentSemester.CalculateSemesterAverage()
            // TODO: Delete from all_semesters
            // all_semesters[CurrentSemesterIndex].RemoveCourse(i_index: indexPath.row)
            self.SemesterAverageLabel.text = "Average : \(CurrentSemester.Average.roundToDecimal(1))%"
            UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            tableView.reloadData()
            
        }
        
    }
    
    
    public func AddViews (){
        
        tempView.bounds = UIScreen.main.bounds
        tempView.center = view.center
        tempView.layer.backgroundColor = UIColor.darkGray.cgColor
        tempView.alpha = 0.8
        self.view.addSubview(tempView)
        self.newCourseView.center = view.center
        self.newCourseView.transform  = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(self.newCourseView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations:{ self.newCourseView.transform = .identity   })

        
    }
    
    private func getAlert (i_alertNumber : Int) -> UIAlertController{
        let alert1 = UIAlertController(title: "Invalid Name", message: "Please Enter a Valid Course Name", preferredStyle: .alert)
        
        alert1.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        let alert2 = UIAlertController(title: "Invalid Grade", message: "Please Enter a Valid Grade", preferredStyle: .alert)
        
        alert2.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        let alert3 = UIAlertController(title: "Invalid Credits", message: "Please Enter a Valid Credits Amount", preferredStyle: .alert)
        
        alert3.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        if(i_alertNumber == 1){
            
            return alert1
            
        } else if (i_alertNumber == 2){
            
            return alert2
            
        } else {
            
            return alert3
        }
    }
    
   /** Text Field functions **/
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    

}
