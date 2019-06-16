//
//  DetailViewControllerTests.swift
//  JDTestAppTests
//
//  Created by Rameez khan  on 16/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import XCTest
@testable import JDTestApp
class DetailViewControllerTests: XCTestCase {
  var container: FileContainer?
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      let testFiles = [File(type: "mp3", size: 2000, name: "Test_AudioFile", description: "This is a test description")]
      container = FileContainer(typeIdentifier: "Audio", files: testFiles)
     
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      container = nil
    }

  func testLoadingFileContainers() {
    if let fileContainer = container {
      let sut = DetailViewController(withContainer: fileContainer)
      sut.loadViewIfNeeded()
      XCTAssertEqual(sut.container.files.count, 1, "There should be 1 file in the container")
    }
  }
  
  func testIfTableViewExists() {
    if let fileContainer = container {
      let sut = DetailViewController(withContainer: fileContainer)
      sut.loadViewIfNeeded()
      XCTAssertNotNil(sut.tableView)
    }
  }
  
  func testTableViewHasCorrectRowCount() {
    if let fileContainer = container {
      let sut = DetailViewController(withContainer: fileContainer)
      sut.loadViewIfNeeded()
      XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), sut.container.files.count)
    }
  }
  
  func testEachCellHasCorrectText() {
    if let fileContainer = container {
      let sut = DetailViewController(withContainer: fileContainer)
      sut.loadViewIfNeeded()
      for(index, _) in sut.container.files.enumerated() {
        let indexPath = IndexPath(item: index, section: 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath) as? DetailsTableViewCell
        XCTAssertEqual(cell?.fileNameLabel.text, "Test_AudioFile", "File name not matching")
        XCTAssertEqual(cell?.fileDescriptionLabel.text, "This is a test description", "File description incorrect")
        XCTAssertEqual(cell?.fileSizeLabel.text, "File size is 2000", "File size text not matching")
        XCTAssertEqual(cell?.fileTypeLabel.text, "mp3", "File type not matching")
        
      }
    }
  }
  
  func testNavigationBarHasStormViewTitle() {
    if let fileContainer = container {
      let sut = DetailViewController(withContainer: fileContainer)
      sut.loadViewIfNeeded()
      XCTAssertEqual(sut.title, container?.typeIdentifier)
    }
  }

}
