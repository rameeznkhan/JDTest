//
//  MasterViewControllerTests.swift
//  JDTestAppTests
//
//  Created by Rameez khan  on 16/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import XCTest
@testable import JDTestApp
class MasterViewControllerTests: XCTestCase {
  var sut: MasterViewController?
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    sut = MasterViewController()

  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    sut = nil
  }
  
  func testLoadingFileContainers() {
    sut?.loadViewIfNeeded()
    XCTAssertEqual(sut?.fileContainerArray.count, 4, "There should be 4 containers")
  }
  
  func testIfTableViewExists() {
    sut?.loadViewIfNeeded()
    XCTAssertNotNil(sut?.tableView)
  }
  
  func testTableViewHasCorrectRowCount() {
    sut?.loadViewIfNeeded()
    XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), sut?.fileContainerArray.count)
  }
  
  func testEachCellHasCorrectText() {
    sut?.loadViewIfNeeded()
    //Safe to use exclaimation as we are initialising sut under the setup function which will be called when the test starts
    for(index, fileContainer) in sut!.fileContainerArray.enumerated() {
      let indexPath = IndexPath(item: index, section: 0)
      let cell = sut?.tableView(sut!.tableView, cellForRowAt: indexPath)
      XCTAssertEqual(cell?.textLabel?.text, "\(fileContainer.typeIdentifier), Total number of files: \(fileContainer.files.count)", "FileContainers row text doesn't match")
    }
  }
  
  func testCellHaveDisclosureIndicators() {
    sut?.loadViewIfNeeded()
    for(index, _) in sut!.fileContainerArray.enumerated() {
      let indexPath = IndexPath(item: index, section: 0)
      let cell = sut?.tableView(sut!.tableView, cellForRowAt: indexPath)
      XCTAssertEqual(cell?.accessoryType, .disclosureIndicator)
    }
  }
  
  func testViewControllerUsesLargeTitles() {
    _ = UINavigationController(rootViewController: sut!)
    sut?.loadViewIfNeeded()
    XCTAssertTrue(sut?.navigationController?.navigationBar.prefersLargeTitles ?? false)
  }
  
  func testNavigationBarHasStormViewTitle() {
    sut?.loadViewIfNeeded()
    XCTAssertEqual(sut?.title, "Files")
    
  }
}
