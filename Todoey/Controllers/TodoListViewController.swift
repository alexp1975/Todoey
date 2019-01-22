//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 22/01/2019.
//  Copyright © 2019 Advanced Tech. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem1 = Item()
        newItem1.title = "Egg"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Bacon"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Sausage"
        itemArray.append(newItem3)
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        
    
        
        
        
       
    }
    
    
    //MARK  - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
            cell.textLabel?.text = item.title
        //Ternary
            cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // - TableView Delegat Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)

}

//Mark - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            print("Success")
 //////sort out empty msg
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            
            
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
