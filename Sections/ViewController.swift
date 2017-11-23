//
//  ViewController.swift
//  Sections
//
//  Created by aviezer group on 22/11/17.
//  Copyright © 2017 aviezer group. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, ContactsCellProtocol {
    let cellId = "cellId"
    
    func touchFavoriteMark(cell: ContactsCell) {
        print("Inside of VewController now")
        
        // we're going to figure out wicht name we're clicking on
        
        
        guard let indexPathTapped = tableView.indexPath(for: cell) else {
            return
        }
        
        let contact = twoDimensionArray[indexPathTapped.section].names[indexPathTapped.row]
        
        let hasFavorited = contact.hasFavorited
        
        twoDimensionArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
        
    }
    
    var twoDimensionArray = [
        ExpandableNames(isExpanded: true, names: ["Any", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"]
            .map { Contact(name: $0, hasFavorited: false) }
        ),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christine", "Cameron"]
            .map { Contact(name: $0, hasFavorited: false) }
        ),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"]
            .map { Contact(name: $0, hasFavorited: false) }
        ),
        ExpandableNames(isExpanded: true, names: [
            Contact(name: "Patrick", hasFavorited: false),
            Contact(name: "Patty", hasFavorited: false)
            ]
        )
    ]
    
    var showIndexPath = false
    
    @objc func handleShowIndexPath(){
        
        print("Atthemping reload animation of indexPath...")
        
        // build all the indexPaths we want reload
        
        var indexPathToReload = [IndexPath]()
        
        for section in twoDimensionArray.indices {
            
            if !twoDimensionArray[section].isExpanded {
                continue
            }
            
            for row in twoDimensionArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        
        
        showIndexPath = !showIndexPath
        
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        tableView.register(ContactsCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        button.tag = section
        
        return button
        
        
        //        let rect = CGRect(x: 0, y:0, width: tableView.frame.width, height: 44)
        //
        //        let label = UILabel(frame: rect)
        //        label.text = "Header"
        //        label.backgroundColor = UIColor.lightGray
        //        return label
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we´ll try to close the section first by deleting rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionArray[section].names.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        // Es necesario tambien limpiar la collecion de datos sino da error
        // Recordar que eso ya no es necesario con la correccion
        
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionArray[section].names.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactsCell
        
        
        //        let name = self.names[indexPath.row]
        
        let contact = twoDimensionArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
        if(showIndexPath){
            cell.textLabel?.text = "\(contact.name) Sections: \(indexPath.section) Row: \(indexPath.row)"
        }
        
        cell.delegate = self
        
        return cell
        
    }
    
}

