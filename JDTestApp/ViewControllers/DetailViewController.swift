//
//  DetailViewController.swift
//  JDTestApp
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
  let container: FileContainer
  var selectedIndexPath: IndexPath?
  init(withContainer container: FileContainer) {
    self.container = container
    super.init(style: .plain)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    title = container.typeIdentifier
    tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.description())
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return container.files.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.description()) as? DetailsTableViewCell else {fatalError("Can't deque Cell")}
    let file = container.files[indexPath.row]
    cell.configureCell(file)
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndexPath = indexPath
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let selectedIndexPath = selectedIndexPath  else {return 44.0}
    return selectedIndexPath == indexPath ? 176.0 : 44.0
  }
}
