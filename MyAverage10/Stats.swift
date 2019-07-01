//
//  Stats.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-27.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import Foundation

import UIKit


class Stats {
    
    
    /** Data Members **/
    
    private var m_BestClass:Course!
    private var m_WorstClass:Course!
    private var m_BestSemester:Semester!
    private var m_WorstSemester:Semester!
    private var m_BestYear:Int!
    private var m_WorstYear:Int!
    private var m_StandardDiviation : Double!
    private var m_TotalAverage : Double!
    private var m_TotalCredits : Double!
    
    
    
    /** Getters and Setters **/
    
    var BestClass: Course {
        get { return self.m_BestClass; }
        set { m_BestClass = newValue; }
    }
    var WorstClass: Course {
        get { return self.m_WorstClass; }
        set { m_WorstClass = newValue; }
    }
    var BestSemester: Semester {
        get { return self.m_BestSemester; }
        set { m_BestSemester = newValue; }
    }
    var WorstSemester: Semester {
        get { return self.m_WorstSemester; }
        set { m_WorstSemester = newValue; }
    }
    var BestYear: Int {
        get { return self.m_BestYear; }
        set { m_BestYear = newValue; }
    }
    var WorstYear: Int {
        get { return self.m_WorstYear; }
        set { m_WorstYear = newValue; }
    }
    var StandardDiviation: Double {
        get { return self.m_StandardDiviation; }
        set { m_StandardDiviation = newValue; }
    }
    var TotalAverage: Double {
        get { return self.m_TotalAverage; }
        set { m_TotalAverage = newValue; }
    }
    var TotalCredits: Double {
        get { return self.m_TotalCredits; }
        set { m_TotalCredits = newValue; }
    }

    /** Constructor **/
    
    init() {
        
        self.m_TotalAverage = getTotalAverage()
        self.m_TotalCredits = self.calculateTotalCredits()
        self.m_StandardDiviation = self.calculateStandardDiviation()
        highestClass()
        self.m_BestYear = self.getBestYear()
        self.m_WorstYear = self.getWorstYear()
    }
    
    
    /* Calculation Functions */
    
    private func calculateTotalCredits() -> Double {
        var total = 0.0
        for i in all_semesters {
            for j in i.Courses{
                total += j.Credits
            }
        }
        
        return total
    }
    
    private func calculateStandardDiviation() -> Double{
        
        let mean = getTotalAverage()
        
        var sum = 0.0
        var count = 0.0
        for i in all_semesters {
            for j in i.Courses{
                sum += (j.Grade - mean) * (j.Grade - mean)
                count += 1
            }
        }
        sum = (1 / count) * sum
        sum = sum.squareRoot()
        return sum
    }
    
    
    
    /* get highest and lowest class and semester */
    
    private func highestClass() {
        var highestClass = all_semesters[0].Courses[0]
        var lowestClass = all_semesters[0].Courses[0]
        var highestSem = all_semesters[0]
        var lowestSem = all_semesters[0]
        
        for i in all_semesters {
            
            
            if(i.Average > highestSem.Average){
                highestSem = i
            }
            if(i.Average < lowestSem.Average){
                lowestSem = i
            }
            
            
            
            for j in i.Courses{
                
                if(j.Grade > highestClass.Grade){
                    highestClass = j
                }
                if(j.Grade < lowestClass.Grade){
                    lowestClass = j
                }
            }
        }
        
        self.m_BestClass = highestClass
        self.m_WorstClass = lowestClass
        self.m_BestSemester = highestSem
        self.m_WorstSemester = lowestSem
    }
    
    
    public func getYearAverage(i_year : Int) -> Double {
        
        var average = 0.0;
        var weight = 0.0;
        
        for semester in all_semesters {
            if (semester.Year == i_year){
                for course in semester.Courses {
                    average += (course.Grade * course.Credits)
                    weight += course.Credits;
                }
            }
        }
        
        average = average / weight;
        
        if (average.isNaN){
            average = 0.0;
        }
        
        return average;
    }
    
    private func getBestYear() -> Int{
        
        let year1Average = self.getYearAverage(i_year: 1)
        let year2Average = self.getYearAverage(i_year: 2)
        let year3Average = self.getYearAverage(i_year: 3)
        
        
        
        if(year1Average >  year2Average && year1Average >  year3Average  ){
            return 1
        }
        
        if(year2Average >  year1Average && year2Average >  year3Average  ){
            return 2
        }
        
        if(year3Average >  year2Average && year3Average >  year1Average  ){
            return 3
        }
        
        return 1
    }
    
    func getWorstYear() -> Int{
        
        let year1Average = self.getYearAverage(i_year: 1)
        let year2Average = self.getYearAverage(i_year: 2)
        let year3Average = self.getYearAverage(i_year: 3)
        
        
        
        if(year1Average <  year2Average && year1Average <  year3Average  ){
            return 1
        }
        
        if(year2Average <  year1Average && year2Average <  year3Average  ){
            return 2
        }
        
        if(year3Average <  year2Average && year3Average <  year1Average  ){
            return 3
        }
        
        return 1
    }
    
}
