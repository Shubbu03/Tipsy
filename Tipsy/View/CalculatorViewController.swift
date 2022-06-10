

//
//  ViewController.swift
//  Tipsy
//

//

import UIKit

class CalculatorViewController: UIViewController {

    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // initialize tip by giving any random value
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"

    
    @IBAction func tipChanged(_ sender: UIButton) {
       
        
        // deselect all first
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // now see if user selects any button among three
        sender.isSelected = true
        
        // we will store which button is clicked by this
        let title = sender.currentTitle!
        
        //as selected is a uibutton we will force unwrap it to a string
        let buttonTitle = String(title.dropLast())
        
        // to divide final tip we have to convert that string in double
        let doubleButton = Double(buttonTitle)!
        
        // tip is calculated by dividing it by 100
        
        tip = doubleButton / 100 // this is final tip
        
        billTextField.endEditing(true) //not to allow the onscreen keyboard to appear
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        numberOfPeople = Int(sender.value)
        
        splitNumberLabel.text = String(format: "%.0f", sender.value) // this is final total number of people
    
    }

    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        
        //If the text is not an empty String ""
        if bill != "" {
            
            //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
            //e.g. 125.50
            billTotal = Double(bill)!
            
            //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            
            //Round the result to 2 decimal places and turn it into a String.
            
            finalResult = String(format: "%.2f", result) // this is final bill after doing everything
            
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self) // to call the second screen after pressing a button

}
    //This method gets triggered just before the segue starts.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the currently triggered segue is the "goToResults" segue.
        if segue.identifier == "goToResult" {
            
            //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
            let lastBill = segue.destination as! ResultsViewController
            
            //Set the destination ResultsViewController's properties.
//            latestBill.result = finalResult
//            latestBill.tip = Int(tip * 100)
//             latestBill.split = numberOfPeople
            
            lastBill.result = finalResult
            lastBill.tip = Int(tip * 100)
            lastBill.split = numberOfPeople
        }
    }

}
