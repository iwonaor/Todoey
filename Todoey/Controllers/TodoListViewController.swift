//
//  ViewController.swift
//  Todoey
//
//  Created by Iwona Orocz on 05/08/2018.
//  Copyright © 2018 Iwona Orocz. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item] ()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Have fun"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Have sex"
        itemArray.append(newItem3)
        

        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
          itemArray = items}
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        //Ternary operator
        //value = condition ? valueifTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //if item.done == true {
         //   cell.accessoryType = .checkmark }
       // else {
            
          //  cell.accessoryType = .none
        //}
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        //if itemArray[indexPath.row].done == false {
          //  itemArray[indexPath.row].done = true }
        //else {
          //  itemArray[indexPath.row].done = false}
       //tableView.reloadData()
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)}
    
    //Add new items - przycisk ktory dodaje nowe pozycje - pojawia sie popup z info
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title:"Add New Todoey Item", message: "", preferredStyle: .alert)
 
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData() //sposob na to zeby dodawaly sie nowe pozycje do tabelki
    }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
}


}
