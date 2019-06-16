//
//  DataStoreTests.swift
//  JDTestAppTests
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import XCTest
@testable import JDTestApp
class DataStoreTests: XCTestCase {
  var fileData: Data?
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    do {
    guard let fileURL = Bundle.main.url(forResource: "Test", withExtension: "json") else { throw FileError.fileNotFound}
      fileData = try Data.init(contentsOf: fileURL)
    } catch let e {
      XCTFail(e.localizedDescription)
    }
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    fileData = nil
  }
  
  
  func testJSONConversionFromFile() {
    do {
      guard let fileData = fileData else {fatalError("File data not initialised")}
      let json = try DataStore.getJSONFromData(fileData)
      XCTAssertNotNil(json)
      XCTAssertEqual(json.count, 4, "There are only four elements")
      if let firstElement = json.first {
        XCTAssertEqual(firstElement["Type"] as? String, "jpg", "Type Mismatch")
        XCTAssertEqual(firstElement["Name"] as? String, "TestImage_1", "Name Mismatch")
      }
    } catch let e {
      XCTFail(e.localizedDescription)
    }
  }
  
  func testConversionToFile() {
    do {
      guard let fileData = fileData else {fatalError("File data not initialised")}
      let json = try DataStore.getJSONFromData(fileData)
      let fileArray = DataStore.convertToFileType(withJSON: json)
      XCTAssertNotNil(fileArray)
      XCTAssertEqual(fileArray.count, 4, "Only four files in json file")
    } catch let e {
      XCTFail(e.localizedDescription)
    }
  }
  
  func testConversionToContainers() {
    do {
      guard let fileData = fileData else {fatalError("File data not initialised")}
      let json = try DataStore.getJSONFromData(fileData)
      let fileArray =  DataStore.convertToFileType(withJSON: json)
      let containers = DataStore.formatFilesAccordingToTypes(files: fileArray)
      XCTAssertNotNil(containers)
      XCTAssertEqual(containers.count, 4, "All container's for conversion should be initialised")
      for container in containers {
        XCTAssertEqual(container.files.count, 1, "Each container should have one file")
      }
    } catch let e {
      XCTFail(e.localizedDescription)
    }
  }
  
  
  func testFilterForFileType() {
    let files = [File(type: "mp3", size: 200, name: "TestAudio", description: "This is an audio file"), File(type: "avi", size: 200, name: "TestVideo", description: "This is a sample description"),
    File(type: "dll", size: 200, name: "TestExecutable", description: "This is a sample description"),
    File(type: "jpg", size: 200, name: "TestImage", description: "This is a sample description")]
    let audioTypes = FileType.Audios.allAudios
    let filteredAudio = DataStore.filterFiles(from: files, with: audioTypes)
    XCTAssertEqual(filteredAudio.count, 1, "There should only be 1 file")
    let filteredAudioFile = filteredAudio.first
    if let audioFile = filteredAudioFile {
      XCTAssertEqual(audioFile.name, "TestAudio", "Name doesn't match")
      XCTAssertEqual(audioFile.type, "mp3", "Type doesn't match")
      XCTAssertEqual(audioFile.description, "This is an audio file", "Description doesn't match")
      XCTAssertEqual(audioFile.size, 200, "Size doesn't match")
    }
  }
}
