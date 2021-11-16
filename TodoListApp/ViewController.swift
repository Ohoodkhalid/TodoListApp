//
//  ViewController.swift
//  TodoListApp
//
//  Created by administrator on 13/10/2021.
//

import UIKit


protocol AddEvent {
    func AddItem (by :ViewController , title : String , detalis : String,date :String)
}

class ViewController: UIViewController {
    
    var delegateAddItem :AddEvent?
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var TitleTextField: UITextField!
    
    
    
    @IBOutlet weak var DetailsTextField: UITextField!
     
    
    @IBAction func AddItem(_ sender: Any) {
        
    // 
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd,mm,yyy"
        let dateOfEvent = format.string(from: date)
        
        
        
       let title = TitleTextField.text!
     let details = DetailsTextField.text!
        delegateAddItem?.AddItem(by : self ,title:title , detalis: details ,date :dateOfEvent )

        self.navigationController?.popViewController(animated: true)
        
    }

   
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
       
     
        
    }
  
       
         
     }



