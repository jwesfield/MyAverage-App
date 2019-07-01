//
//  GlobalFunctions.swift
//  My_Average_3
//
//  Created by Jonathan  Wesfield on 2017-04-06.
//  Copyright © 2017 JonnyWes. All rights reserved.
//

import Foundation

var all_semesters = [Semester]()
var all_courses = [Course]()

 let tempView = UIViewX()


public enum Sem {
    case A
    case B
    case C
    case D
}


public func SemesterListToDictionary() -> [[Dictionary<String , String>]]{
    print("PARTTTTY")
    var InfoDic = [[Dictionary<String, String>]]()
    
    for semester in all_semesters {
        
        var SemesterDic = [Dictionary<String, String>]()
        
        for course in semester.Courses {
            
            var courseDic = Dictionary<String, String>()
            
            courseDic["CourseName"] = "\(course.Name)"
            courseDic["CourseGrade"] = "\(course.Grade)"
            courseDic["CourseCredits"] = "\(course.Credits)"
            courseDic["CourseSemester"] = "\(course.Semester)"
            courseDic["CourseYear"] = "\(course.Year)"
            
            SemesterDic.append(courseDic)
        }
        
       var SemesterInfoDic = Dictionary<String, String>()
         SemesterInfoDic["SemesterAverage"] = "\(semester.Average)"
         SemesterInfoDic["SemesterCredits"] = "\(semester.Credits)"
         SemesterInfoDic["SemesterYear"] = "\(semester.Year)"
         SemesterInfoDic["SemesterSem"] = "\(semester.SemesterLetter)"
        
        SemesterDic.append(SemesterInfoDic)
        InfoDic.append(SemesterDic)
        
    }
    print(InfoDic)
    print("DONE")
    return InfoDic
}



public func ArrayOfSemestersFromDictionary(){

    if let data = UserDefaults.standard.array(forKey: "data2") as? [[Dictionary<String, String>]]{
      
        var semestersArray = [Semester]()
        
        
        print("YYAAAAAAYYY")
            print(data)
        
        
        for i in data {
            
           var currentSemesterInfo = i.last
        
            var sem_Average = 0.0
            var sem_Sem = Sem.A
            var sem_credits = 0.0
            var sem_year = 1
            
            if let semesterCurrentAverage = currentSemesterInfo?["SemesterAverage"] {
                sem_Average = Double(semesterCurrentAverage)!
            }
            if let semesterCurrentCredits = currentSemesterInfo?["SemesterCredits"] {
                sem_credits = Double(semesterCurrentCredits)!
            }
            if let semesterCurrentSem = currentSemesterInfo?["SemesterSem"] {
               
                switch semesterCurrentSem  {
                case "A":
                    sem_Sem = Sem.A
                    break
                case "B" :
                    sem_Sem = Sem.B
                    break
                default:
                    sem_Sem = Sem.C
                }
                
                
            }
            if let semesterCurrentYear = currentSemesterInfo?["SemesterYear"] {
                sem_year = Int(semesterCurrentYear)!
            }
            
            var newSemester = Semester(i_semester: sem_Sem, i_average: sem_Average, i_credits: sem_credits, i_year: sem_year)
            
            for j in i {
                
                if (j == i.last!) {
                    break
                }
                
                var name = ""
                var grade = 0.0
                var credits = 0.0
                var year = 0
                
                
                
                if let courseYear = j["CourseYear"] {
                   year = Int(courseYear)!
                }
                if let courseName = j["CourseName"] {
                    name = courseName
                }
                if let courseGrade = j["CourseGrade"] {
                    if let grade1 = Double(courseGrade) {
                        grade = grade1
                    } else {
                        grade = 77.0
                    }
                }
                if let courseCredits = j["CourseCredits"] {
                    credits = Double(courseCredits)!
                }
              
                
                let newCourse = Course(i_Name: name, i_Grade: grade, i_Credits: credits, i_Year: year, i_Parent: newSemester, i_CountTowardsGPA: true ) // fix
                newSemester.AddCourse(i_course: newCourse)
                
            }
            
            semestersArray.append(newSemester)
        }
        
        all_semesters = semestersArray
        
        for i in semestersArray {
            // print(i.GetAverage)
            for j in i.Courses{
                //  print(j.GetName)
            }
        }
        
    } else {
        print("Sorry jonny no data POOO")
    }
    
    

    
}

/*
func setData(){
    
    
    let s1 = Semester(i_semester: Sem.A, i_average: 60.0, i_credits: 4.0, i_year: 1)
    let s2 = Semester(i_semester: Sem.B, i_average: 70.0, i_credits: 5.0, i_year: 2)
    let s3 = Semester(i_semester: Sem.C, i_average: 80.0, i_credits: 6.0, i_year: 3)
    let s4 = Semester(i_semester: Sem.A, i_average: 90.0, i_credits: 7.0, i_year: 3)
    
    let c1 = Course(i_Name: "Logic", i_Grade: 80.0, i_Credits: 5.0, i_Year: 1, i_Parent: s1)
    let c2 = Course(i_Name: "Linear", i_Grade: 90.0, i_Credits: 4.0, i_Year: 2, i_Parent: s2)
    let c3 = Course(i_Name: "Calc", i_Grade: 70.0, i_Credits: 6.0, i_Year: 2, i_Parent: s2)
    let c4 = Course(i_Name: "Programming", i_Grade: 50.0, i_Credits: 5.0, i_Year: 1, i_Parent: s1)
    let c5 = Course(i_Name: "C#", i_Grade: 70.0, i_Credits: 6.0, i_Year: 1, i_Parent: s1)
    let c6 = Course(i_Name: "Disrete Math", i_Grade: 88.0, i_Credits: 3.0, i_Year: 1, i_Parent: s1)
    
    s1.AddCourse(i_course: c1)
    s2.AddCourse(i_course: c2)
    s2.AddCourse(i_course: c3)
    s1.AddCourse(i_course: c4)
     s1.AddCourse(i_course: c5)
     s1.AddCourse(i_course: c6)
    
    
    all_semesters.append(s1)
    all_semesters.append(s2)
    all_semesters.append(s3)
    all_semesters.append(s4)
    
}
*/


func data4 (){
    
    if let data2 = UserDefaults.standard.object(forKey: "data") as? [Dictionary<String, AnyObject>]{
        //print("JONNNNNY DATA3 is : \(data2)")
        
        for i in data2{
            
            print(i["sem"]!)
            print(i["average"]!)
            print("\(i["year"]!)")
            print("\(i["credits"]!)")
            
            
            if let course_array =  i["courses"]! as? Dictionary<String,AnyObject>{
                
                for i in course_array{
                    print(i)
                    print(i.value)
                    
                }
                
                
            } else {
                print("didnt work")
            }
            
        }
        
    } else {
        print("JONNNNNNY : DIC DIDNT WORk")
    }
    
    
}

func getTotalAverage() -> Double {
    var allAverage = 0.0
    var allWeights = 0.0
    for i in all_semesters {
        for k in i.Courses {
            allAverage += (k.Grade * k.Credits)
            allWeights += k.Credits
        }
    }
    allAverage = allAverage / allWeights
    
    if(allAverage.isNaN){
        allAverage = 0.0
    }
    return allAverage
}


extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}



