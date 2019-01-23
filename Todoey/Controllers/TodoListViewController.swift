//
//  ViewController.swift
//  Todoey
//
//  Created by Alex on 22/01/2019.
//  Copyright © 2019 Advanced Tech. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in:
        .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var itemArray = [Item]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        
        
        loadItems()
        
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

        saveItems()
        
        
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
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated:true, completion: nil)
        
        }
    
    //Mark - Model Manipulation Methods
    func saveItems(){
    
    let encoder = PropertyListEncoder()
    
    do {
    let data = try encoder.encode(itemArray)
    try data.write(to: dataFilePath!)
    } catch {
    print("Error encoding item array, \(error)")
    }
    
    
    self.tableView.reloadData()
    }
    
    func loadItems(){
        
           if let data = try? Data(contentsOf: dataFilePath!){
                let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
    }
}
    
    
}
