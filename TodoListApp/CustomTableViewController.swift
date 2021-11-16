//
//  CustomTableViewController.swift
//  TodoListApp
//
//  Created by administrator on 14/10/2021.
//

import UIKit
import CoreData
//struct Items {
  //  var noteTitle :String
  //  var discrition : String
    
///}
class CustomTableViewController: UITableViewController {
    let mangedOjectContext = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
    var items = [Item]()
   
    
    ///var item = [Item] ()
   /// var items :[Items]=[]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      fetechAllItem()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let distenation = segue.destination as!ViewController
        distenation.delegateAddItem = self
        
        
        
        
    }
    
    func fetechAllItem (){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do {
        let result = try mangedOjectContext.fetch(request)
           items = result as![Item]
        } catch{
            print ("\(error)")
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!CustomTableViewCell
       
       cell.titleLable.text = items[indexPath.row].title!
       cell.noteLable.text = items[indexPath.row].note
        cell.dateLable.text = items[indexPath.row].date
        
        
        
      /// cell.dateLable.text = items[indexPath.row].dateToComlplete!
        return cell
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
     
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
          
            
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
      
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
            try mangedOjectContext.save()
      
        } catch{
            print ("\(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
    
        mangedOjectContext.delete(item)
        do {
            try mangedOjectContext.save()
        }catch{
            print ("\(error)")
        }
        
        items.remove(at: indexPath.row)
        
        tableView.reloadData()
        
    }
    
    
    
    
    
}



extension CustomTableViewController :AddEvent{
    func AddItem(by : ViewController ,title: String, detalis: String, date: String) {
        let myItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: mangedOjectContext )as!Item
        myItem.title = title
        myItem.note = detalis
        myItem.date = date
        items.append(myItem)
       
        do{
       try  mangedOjectContext.save ()
        }catch{
            print ("\(error)")
        }
        tableView.reloadData()
           
     /// let  myitem = Items(noteTitle: title, discrition: detalis)
       /// items.append(myitem)
      
        
        

        
        
        
        
        
    }

    
    
    
}
