//
//  InfoStatsVC.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-19.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit

class InfoStatsVC: UITableViewController {

    /** IBOutlets **/
    
    @IBOutlet weak var bestClassLabel: UILabel!
    @IBOutlet weak var bestClassGradeLabel: UILabel!
    @IBOutlet weak var worstClassLabel: UILabel!
    @IBOutlet weak var worstClassGradeLabel: UILabel!
    @IBOutlet weak var bestSemesterNameLabel: UILabel!
    @IBOutlet weak var bestSemesterAverageLabdl: UILabel!
    @IBOutlet weak var bestSemesterCreditsLabel: UILabel!
    @IBOutlet weak var worstSemesterNameLabel: UILabel!
    @IBOutlet weak var worstSemesterAverageLabel: UILabel!
    @IBOutlet weak var worstSemesterCreditsLabel: UILabel!
    @IBOutlet weak var bestYearNameLabel: UILabel!
    @IBOutlet weak var bestYearAverageLabel: UILabel!
    @IBOutlet weak var bestYearCreditsLabel: UILabel!
    @IBOutlet weak var worstYearNameLabel: UILabel!
    @IBOutlet weak var worstYearAverageLabel: UILabel!
    @IBOutlet weak var worstYearCreditsLabel: UILabel!
    @IBOutlet weak var standardDiviationLabel: UILabel!
    @IBOutlet weak var totalCreditsLabel: UILabel!
    
    /** Constructor **/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(all_semesters.count > 0){
            let stats = Stats()
            setUpLabels(stats: stats)
        } else {
            let alert = UIAlertController(title: "No Courses", message: "Please Return and Select Courses", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /** Class Logic **/
    
    func setUpLabels(stats : Stats){
        
        self.bestClassLabel.text = stats.BestClass.Name
        self.bestClassGradeLabel.text = "\(stats.BestClass.Grade)"
        
        self.worstClassLabel.text = stats.WorstClass.Name
        self.worstClassGradeLabel.text = "\(stats.WorstClass.Grade)"
        
        
        
        self.bestSemesterNameLabel.text = "Year: \(stats.BestSemester.Year) Semester: \(stats.BestSemester.SemesterLetter)"
        self.bestSemesterAverageLabdl.text = "\(stats.BestSemester.Average.roundToDecimal(1))"
        self.bestSemesterCreditsLabel.text = "\(stats.BestSemester.Credits)"
        
        self.worstSemesterNameLabel.text = "Year: \(stats.WorstSemester.Year) Semester: \(stats.WorstSemester.SemesterLetter)"
        self.worstSemesterAverageLabel.text = "\(stats.WorstSemester.Average.roundToDecimal(1))"
        self.worstSemesterCreditsLabel.text = "\(stats.WorstSemester.Credits)"
        
        
        
        self.bestYearNameLabel.text = "Year : \(stats.BestYear)"
        self.bestYearAverageLabel.text = "\(stats.getYearAverage(i_year: stats.BestYear).roundToDecimal(1))"
        self.bestYearCreditsLabel.text = ""
        
        self.worstYearNameLabel.text = "Year : \(stats.WorstYear)"
        self.worstYearAverageLabel.text = "\(stats.getYearAverage(i_year: stats.WorstYear).roundToDecimal(1))"
        self.worstYearCreditsLabel.text = ""
        
        
        
        self.standardDiviationLabel.text = "\(stats.StandardDiviation.roundToDecimal(1))"
        
        self.totalCreditsLabel.text = "\(stats.TotalCredits)"
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 2
    }

  
 

}

