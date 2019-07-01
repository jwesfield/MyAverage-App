//
//  Improvments.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-05-03.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import Foundation


class Improvments {
    
    
    /** Data Members **/
    
    private var m_Courses: [Course]!
    
    private var m_IsOneSemester : Bool!
    private var m_IsOneYear = true
    
    private var m_CurrentSem : Semester!
    private var m_CurrentYear : Int!
    
    private var m_CurrentSemAverage:Double!
    private var m_CurrentYearAverage:Double!
    private var m_CurrentTotalAverage:Double!
    
    private var m_TotalCredits : Double!
    private var m_YearCredits : Double!
    private var m_SemesterCredits : Double!
    
    private var m_NewSemAverage:Double!
    private var m_NewYearAverage:Double!
    private var m_NewTotalAverage = getTotalAverage()
    
    private var m_TotalImprovment  = 0.0
    private var m_YearImprovment = 0.0
    private var m_SemesterImprovment = 0.0
    
    private var m_IsIncrease_semester = false
    private var m_IsIncrease_year = false
    private var m_IsIncrease_total = false
    
    
    
    
    /** Getters and Setters **/
    
    
    public var Courses: [Course] {
        get { return self.m_Courses; }
        set { m_Courses = newValue; }
    }
    public var IsOneSemester: Bool {
        get { return self.m_IsOneSemester; }
        set { m_IsOneSemester = newValue; }
    }
    public var IsOneYear: Bool {
        get { return self.m_IsOneYear; }
        set { m_IsOneYear = newValue; }
    }
    public var CurrentSem: Semester {
        get { return self.m_CurrentSem; }
        set { m_CurrentSem = newValue; }
    }
    public var CurrentYear: Int {
        get { return self.m_CurrentYear; }
        set { m_CurrentYear = newValue; }
    }
    public var CurrentSemAverage: Double {
        get { return self.m_CurrentSemAverage; }
        set { m_CurrentSemAverage = newValue; }
    }
    public var CurrentYearAverage: Double {
        get { return self.m_CurrentYearAverage; }
        set { m_CurrentYearAverage = newValue; }
    }
    
    public var CurrentTotalAverage: Double {
        get { return self.m_CurrentTotalAverage; }
        set { m_CurrentTotalAverage = newValue; }
    }
    public var TotalCredits: Double {
        get { return self.m_TotalCredits; }
        set { m_TotalCredits = newValue; }
    }
    public var YearCredits: Double {
        get { return self.m_YearCredits; }
        set { m_YearCredits = newValue; }
    }
    public var SemesterCredits: Double {
        get { return self.m_SemesterCredits; }
        set { m_SemesterCredits = newValue; }
    }
    public var NewSemAverage: Double {
        get { return self.m_NewSemAverage; }
        set { m_NewSemAverage = newValue; }
    }
    public var NewYearAverage: Double {
        get { return self.m_NewYearAverage; }
        set { m_NewYearAverage = newValue; }
    }
    
    public var NewTotalAverage: Double {
        get { return self.m_NewTotalAverage; }
        set { m_NewTotalAverage = newValue; }
    }
    public var TotalImprovment: Double {
        get { return self.m_TotalImprovment; }
        set { m_TotalImprovment = newValue; }
    }
    public var YearImprovment: Double {
        get { return self.m_YearImprovment; }
        set { m_YearImprovment = newValue; }
    }
    public var SemesterImprovment: Double {
        get { return self.m_SemesterImprovment; }
        set { m_SemesterImprovment = newValue; }
    }
    public var isIncreasingSemester: Bool {
        get { return self.m_IsIncrease_semester; }
        set { m_IsIncrease_semester = newValue; }
    }
    public var isIncreasingYear: Bool {
        get { return self.m_IsIncrease_year; }
        set { m_IsIncrease_year = newValue; }
    }
    public var isIncreasingTotal: Bool {
        get { return self.m_IsIncrease_total; }
        set { m_IsIncrease_total = newValue; }
    }
    
    
    

    
    
    init(i_courses : [Course]){
        self.m_CurrentTotalAverage = getTotalAverage()
        self.m_Courses = i_courses
        if(m_Courses.count < 1){
            return
        }
        is_One_Year()
        
        is_One_Semester()
        
        totalCredits()
        
        if (m_IsOneSemester == true){
            get_Semester_Average(i_Semester: self.m_CurrentSem)
        }
        
        if (m_IsOneYear == true){
            get_Year_Average(i_Year: self.m_CurrentYear)
        }
        
        
    }
    
    
    /*** ***/
    
    func updateValues(i_CourseIndex : Int , i_IsIncreasing : Bool){
        
        let course = self.m_Courses[i_CourseIndex]
        
        let totalWight = course.Credits / self.m_TotalCredits
        
        if(self.m_IsOneSemester == true){
            let semesterWeight = course.Credits / self.m_SemesterCredits
            if(i_IsIncreasing == true){
                self.m_NewSemAverage! += semesterWeight
            } else {
                self.m_NewSemAverage! -= semesterWeight
            }
            
            if(self.m_NewSemAverage > self.m_CurrentSemAverage){
                self.m_SemesterImprovment = self.m_NewSemAverage - self.m_CurrentSemAverage
                self.m_IsIncrease_semester = true
            } else if(self.m_NewSemAverage < self.m_CurrentSemAverage){
                self.m_SemesterImprovment = self.m_CurrentSemAverage - self.m_NewSemAverage
                self.m_IsIncrease_semester = false
            } else {
                self.m_SemesterImprovment = 0.0
            }
            
            
            
        }
        
        if(self.m_IsOneYear == true){
            let yearWeight = course.Credits / self.m_YearCredits
            if(i_IsIncreasing == true){
                self.m_NewYearAverage! += yearWeight
            } else {
                self.m_NewYearAverage! -= yearWeight
            }
            
            
            
            if(self.m_NewYearAverage > self.m_CurrentYearAverage){
                self.m_YearImprovment = self.m_NewYearAverage - self.m_CurrentYearAverage
                self.m_IsIncrease_year = true
            } else if(self.m_NewYearAverage < self.m_CurrentYearAverage){
                self.m_YearImprovment = self.m_CurrentYearAverage - self.m_NewYearAverage
                self.m_IsIncrease_year = false
            } else {
                self.m_YearImprovment = 0.0
            }
        }
        
        
        if(self.m_NewTotalAverage > self.m_CurrentTotalAverage){
            self.m_TotalImprovment = self.m_NewTotalAverage - self.m_CurrentTotalAverage
            self.m_IsIncrease_total = true
        } else if(self.m_NewTotalAverage < self.m_CurrentTotalAverage){
            self.m_TotalImprovment = self.m_CurrentTotalAverage - self.m_NewTotalAverage
            self.m_IsIncrease_total = false
        } else {
            self.m_TotalImprovment = 0.0
        }
        
        if(i_IsIncreasing == true){
            self.m_NewTotalAverage += totalWight
        } else {
            self.m_NewTotalAverage -= totalWight
        }
        
    }
    
    
    
    
    
    
    private func is_One_Semester(){
//          let firstSem = self.m_courses[0].ParentSemester
//          for i in self.m_courses{
//           /*
//            if(i.parent_Semester.key !=  firstSem.key){
//                self.m_isOneSemester = false
//                return
//            }
//        }
//         */}
        self.m_IsOneSemester = true
        self.m_CurrentSem = self.m_Courses[0].ParentSemester
    }
    
    private func is_One_Year(){
        let firstSem = self.m_Courses[0].Year
        for i in self.m_Courses{
            if(i.Year != firstSem){
                self.m_IsOneYear = false
                return
            }
        }
        self.m_IsOneSemester = true
        self.m_CurrentYear = self.m_Courses[0].Year
    }
    
    
    
    /******************/
    
    private func totalCredits(){
        var total = 0.0
        for i in all_semesters {
            for j in i.Courses{
                total += j.Credits
            }
        }
        self.m_TotalCredits = total
    }
    
    
    private func get_Semester_Average(i_Semester : Semester) {
        let courses = i_Semester.Courses
        var average = 0.0
        var weight = 0.0
        for i in courses {
            average += i.Grade * i.Credits
            weight += i.Credits
        }
        average /= weight
        self.m_SemesterCredits = weight
        self.m_CurrentSemAverage = average
        self.m_NewSemAverage = average
    }
    
    
    private func get_Year_Average(i_Year : Int) {
        var average = 0.0
        var weight = 0.0
        for i in all_semesters {
            if (i.Year == i_Year){
                for j in i.Courses {
                    average += (j.Grade * j.Credits)
                    weight += j.Credits
                }
            }
        }
        average = average / weight
        self.m_YearCredits = weight
        self.m_CurrentYearAverage = average
        self.m_NewYearAverage = average
    }
    
}
