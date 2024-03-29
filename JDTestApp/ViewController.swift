//
//  ViewController.swift
//  JDTestApp
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
  let fileName = "Files"

  var fileContainerArray = [FileContainer]() {
    didSet {
      tableView.reloadData()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    title = fileName
    fileContainerArray = DataStore.getData(fromFile: fileName)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fileContainerArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) else {fatalError("Unable to deque cell")}
    let container = fileContainerArray[indexPath.row]
    cell.textLabel?.text = "\(container.typeIdentifier) Number of File \(container.files.count)"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

