//
//  DetailsTableViewCell.swift
//  JDTestApp
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
  let fileNameLabel: UILabel = {
    let nl = UILabel()
    nl.translatesAutoresizingMaskIntoConstraints = false
    return nl
  }()
  
  let fileSizeLabel: UILabel = {
    let sl = UILabel()
    sl.translatesAutoresizingMaskIntoConstraints = false
    return sl
  }()
  
  let fileTypeLabel: UILabel = {
    let tl = UILabel()
    tl.translatesAutoresizingMaskIntoConstraints = false
    tl.numberOfLines = 0
    return tl
  }()
  
  let fileDescriptionLabel: UILabel = {
    let dl = UILabel()
    dl.translatesAutoresizingMaskIntoConstraints = false
    dl.numberOfLines = 0
    return dl
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUpView() {
    addSubview(fileNameLabel)
    addSubview(fileTypeLabel)
    addSubview(fileSizeLabel)
    addSubview(fileDescriptionLabel)
    self.clipsToBounds = true
    NSLayoutConstraint.activate([
      //name label
      fileNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
      fileNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
      fileNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
      fileNameLabel.heightAnchor.constraint(equalToConstant: 44.0),
      
      //type label
      fileTypeLabel.topAnchor.constraint(equalTo: fileNameLabel.bottomAnchor, constant: 8.0),
      fileTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
      fileTypeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
      
      
      //size label
      fileSizeLabel.topAnchor.constraint(equalTo: fileTypeLabel.bottomAnchor, constant: 8.0),
      fileSizeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
      fileSizeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
      
      //description label
      fileDescriptionLabel.topAnchor.constraint(equalTo: fileSizeLabel.bottomAnchor, constant: 8.0),
      fileDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
      fileDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
      ])
  }
  
  func configureCell(_ file: File) {
    if let name = file.name, let type = file.type, let size = file.size, let description = file.description {
      fileNameLabel.text = name
      fileTypeLabel.text = type
      fileSizeLabel.text = "File size is \(size)"
      fileDescriptionLabel.text = description
    }
  }
}
