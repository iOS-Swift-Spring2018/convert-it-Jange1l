//
//  ViewController.swift
//  convertIt
//
//  Created by montserratloan on 3/8/18.
//  Copyright © 2018 Juan Suarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singSegment: UISegmentedControl!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var results: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    
    var formulasArray = ["Miles to Kilometers",
                         "Kilometers to Miles",
                         "Feet to Meters",
                         "Yards to Meters",
                         "Meters to Feet",
                         "Meers to Yards",
                         "Inches to Cm",
                         "Cm to Inches",
                         "Fahrenheit to Celsius",
                         "Celsius to Fahrenheit",
                         "Quarts to Liters",
                         "Liters to Quarts"]
    
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""
    
    //MARK:- class Methods
    override func viewDidLoad() {

        super.viewDidLoad()
        formulaPicker.dataSource = self
        formulaPicker.delegate = self
        conversionString = formulasArray[formulaPicker.selectedRow(inComponent: 0)]
        userInput.becomeFirstResponder()
        singSegment.isHidden = true
        
    }
    
    func calculateConversion() {
        
        var outputvalue = 0.0
        
        guard let inputvALUE = Double(userInput.text!) else {
            if userInput.text != "" {
                showAlert(title: "Alert Message", message: "\(String(describing: userInput.text)) is not a valid number.")
                print("show alert here, THE VALUE ENTERED WAS NOT A NUMBER")
            }
            return
        }
            
            switch conversionString {
            case "Miles to Kilometers":
                outputvalue = inputvALUE / 0.62137
            case "Kilometers to Miles":
                outputvalue = inputvALUE * 0.62137
            case   "Feet to Meters":
                outputvalue = inputvALUE / 3.2808
            case   "Yards to Meters":
                outputvalue = inputvALUE / 1.0936
            case    "Meters to Feet":
                outputvalue = inputvALUE * 3.2808
            case  "Meers to Yards":
                outputvalue = inputvALUE * 1.0936
            case "Inches to Cm":
                outputvalue = inputvALUE / 0.3937
            case  "Cm to Inches":
                outputvalue = inputvALUE * 0.3937
            case  "Fahrenheit to Celsius":
                outputvalue = (inputvALUE - 32) * (5/9)
            case "Celsius to Fahrenheit":
                outputvalue = (inputvALUE * (9/5)) + 32
            case  "Quarts to Liters":
                outputvalue = inputvALUE / 1.05669
            case  "Liters to Quarts":
                outputvalue = inputvALUE * 1.05669 
            default:
showAlert(title: "Unexpected Error", message: "Contact the developer that \(conversionString)\" could not be identified.")
                
        }
        let formatString = (decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments - 1 ? "%.\(decimalSegment.selectedSegmentIndex+1)f" : "%f")
        let outPutString = String(format: formatString, outputvalue)
        
            results.text = "\(inputvALUE) \(fromUnits) = \(outPutString) \(toUnits)"
        
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- IBActions
    @IBAction func userInputChnaged(_ sender: UITextField) {
        results.text = ""
        if userInput.text?.first == "-" {
            singSegment.selectedSegmentIndex = 1
        }else{
            singSegment.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func convertButtonPressed(_ sender: Any) {
        calculateConversion()
        
    }
    
    @IBAction func decimalSelected(_ sender: UISegmentedControl) {
        calculateConversion()
        
    }
    
    @IBAction func SignSegmentSelected(_ sender: UISegmentedControl) {
        if singSegment.selectedSegmentIndex == 0 {
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
        } else {
            userInput.text = "-" + userInput.text!
            
        }
        if userInput.text != "-" {
        calculateConversion()
        }
    }
}


//MARK:- PickerView Extension
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulasArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulasArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        conversionString = formulasArray[row]
        
        if conversionString.lowercased().contains("Celsius".lowercased()){
            singSegment.isHidden = false
        } else {
            singSegment.isHidden = true
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
            singSegment.selectedSegmentIndex = 0
        }
        
        let unitsArray = formulasArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        results.text = toUnits
        calculateConversion()
     }
    
    
    
    
}
