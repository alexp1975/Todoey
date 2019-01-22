//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 22/01/2019.
//  Copyright © 2019 Advanced Tech. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Egg","Bacon","Yoghurt","Beans"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        
        
        
        
        
        
       
    }
    
    
    //MARK  - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
            cell.textLabel?.text = itemArray[indexPath.row]
        
            return cell
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // - TableView Delegat Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       tableView.deselectRow(at: indexPath, animated: true)
        
        if (tableView.cellForRow(at:indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at:indexPath)?.accessoryType = .none
        }else{
        tableView.cellForRow(at:indexPath)?.accessoryType = .checkmark
    
        }
        

        

}

//Mark - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            print("Success")
 //////sort out empty msg
            self.itemArray.append(textField.text!)
            print(self.itemArray)
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
        
        }
    
}
