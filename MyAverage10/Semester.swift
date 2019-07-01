//
//  Semester.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-06.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import UIKit

class Semester : Equatable{
    
    
    /** Data Members **/
    
    private var m_Average : Double!
    private var m_Credits : Double!
    private var m_Year : Int!
    private var m_SemesterLetter : Sem!
    private var m_Courses : [Course]!
 
    
    /** Getters and Setters **/
    
    var Average: Double {
        get { return self.m_Average; }
        set { self.m_Average = newValue; }
    }
    
    var Credits: Double {
        get { return self.m_Credits; }
        set { self.m_Credits = newValue; }
    }
    
    var Year: Int {
        get { return self.m_Year; }
        set { self.m_Year = newValue; }
    }
    
    var SemesterLetter : Sem {
        get { return self.m_SemesterLetter; }
        set { self.m_SemesterLetter = newValue; }
    }
    
    var Courses: [Course] {
        get { return self.m_Courses; }
        set { self.m_Courses = newValue; }
    }
    
    
    /** Constructor **/
    
    init(i_semester: Sem, i_average: Double , i_credits : Double , i_year: Int){
        
        self.m_SemesterLetter = i_semester
        self.m_Average = i_average
        self.m_Credits = i_credits
        self.m_Year = i_year
        self.m_Courses = [Course]()
        
    }
    
    /** Class Logic **/
    
    public func CalculateSemesterAverage(){
        
        var average = 0.0
        var credits = 0.0
        
        for i in m_Courses {
            
            average += i.Grade * i.Credits
            credits += i.Credits
            
        }
        average /= credits
        
        if(average.isNaN){
            average = 0.0
        }
        
        self.m_Average = average
        self.m_Credits = credits
    }
    
    func AddCourse(i_course: Course){
        self.m_Courses.append(i_course)
    }
    
    func RemoveCourse(i_index: Int){
        self.m_Courses.remove(at: i_index)
    }
    
    
    public static func ==(left: Semester, right: Semester) -> Bool {
        return (left.Year == right.Year) && (left.Credits == right.Credits) && (left.SemesterLetter == right.SemesterLetter) && (left.Credits == right.Credits)
    }
 
}
