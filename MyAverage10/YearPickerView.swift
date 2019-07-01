//
//  YearPickerView.swift
//  MyAverage10
//
//  Created by Jonathan  Wesfield on 2017-05-21.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//


import Foundation
import UIKit

class YearPickerView: UIPickerView, UIPickerViewDelegate , UIPickerViewDataSource {
    
 
    private var years = [1 , 2, 3 , 4]
    
  
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(years[row])"
    }
    
    
    

    
}
