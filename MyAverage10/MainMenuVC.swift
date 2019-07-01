//
//  MainMenuVC.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-19.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//


import UIKit
import UICircularProgressRing

class MainMenuVC: UIViewController , UITableViewDelegate , UITableViewDataSource{

    /** IBOutlets **/
    
    @IBOutlet weak var totalAverageRing: UICircularProgressRingView!
    @IBOutlet weak var semesterPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAverageLabel: UILabel!
    @IBOutlet var newSemesterView: UIViewX!
    
    /** Data Members **/
    
    private var semesters = [Sem.A , Sem.B, Sem.C]
    private var years = [1 , 2, 3 , 4]
    private var customPickerSemesters = SemesterPickerView()
    private var customPickerYears = YearPickerView()
    
    /** Constructor **/
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        setAverageLabelAndRing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.yearPicker.dataSource = customPickerYears
        self.yearPicker.delegate = customPickerYears
        self.semesterPicker.dataSource = customPickerSemesters
        self.semesterPicker.delegate = customPickerSemesters
        
       setAverageLabelAndRing()
    }
    
    
    private func setAverageLabelAndRing(){
        
        let average = getTotalAverage();
        totalAverageLabel.text = "Total Average : \(average.roundToDecimal(1))"
        totalAverageRing.value = CGFloat(average)
    }
    
    
    /** New Semester Functions **/
   
  
    @IBAction func newSemesterPressed(_ sender: Any) {
        tempView.bounds = UIScreen.main.bounds
        tempView.center = view.center
        tempView.layer.backgroundColor = UIColor.darkGray.cgColor
        tempView.alpha = 0.8
        self.view.addSubview(tempView)
        
        self.newSemesterView.center = view.center
        self.newSemesterView.transform  = CGAffineTransform(scaleX: 0.8, y: 1.2)
        view.addSubview(self.newSemesterView)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations:{ self.newSemesterView.transform = .identity   })
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
   00
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let selectedYear = years[self.yearPicker.selectedRow(inComponent: 0)]
        let selectedSemester = semesters[self.semesterPicker.selectedRow(inComponent: 0)]
        let newSemester = Semester(i_semester: selectedSemester, i_average: 0.0, i_credits: 0.0, i_year: selectedYear)
        all_semesters.append(newSemester)
        tableView.reloadData()
        UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
        self.newSemesterView.removeFromSuperview() // close view
        tempView.removeFromSuperview()
        
    }
    

    /*** TableView ***/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_semesters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hey1")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SemesterCell {
            print("hey2")
            let new_semester = all_semesters[indexPath.row]
            cell.configureCell(i_Semester: new_semester)
            // cell.detailButton.tag = indexPath.row
            //cell.tag = indexPath.row
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = all_semesters[indexPath.row]
        performSegue(withIdentifier: "courseListVC", sender: course)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // TODO :  set user defaults
            all_semesters.remove(at: indexPath.row)
            UserDefaults.standard.set(SemesterListToDictionary(), forKey: "data2")
            tableView.reloadData()
           setAverageLabelAndRing()
        } else if editingStyle == .insert {
            
            
        }
    }
    
    
    /** Segue **/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "courseListVC" ) {
            let upcoming = segue.destination as! CourseListVC
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let sem = all_semesters[(indexPath.row)]
                upcoming.CurrentSemester = sem
                upcoming.CurrentSemesterIndex = indexPath.row
            }
        }
    }

}
