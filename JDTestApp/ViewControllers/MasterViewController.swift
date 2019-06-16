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
    navigationController?.navigationBar.prefersLargeTitles = true
    do {
      fileContainerArray = try DataStore.getData(fromFile: fileName)
    } catch let e {
      presentAlert(title: "Error", message: e.localizedDescription, completion: nil)
    }
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
    
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fileContainerArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) else {fatalError("Unable to deque cell")}
    let container = fileContainerArray[indexPath.row]
    cell.textLabel?.text = "\(container.typeIdentifier), Total number of files: \(container.files.count)"
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let container = fileContainerArray[indexPath.row]
    let detailController = DetailViewController(withContainer: container)
    self.navigationController?.pushViewController(detailController, animated: true)
  }
}

