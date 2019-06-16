//
//  DataStore.swift
//  JDTestApp
//
//  Created by Rameez khan  on 15/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import Foundation
class DataStore {
  
  class func getData(fromFile file: String) throws -> [FileContainer] {
    var container = [FileContainer]()
    guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json") else { throw FileError.fileNotFound}
    do {
      let fileData = try Data.init(contentsOf: fileURL)
      let jsonDictionary = try getJSONFromData(fileData)
      let fileTypeArray = DataStore.convertToFileType(withJSON: jsonDictionary)
      container = DataStore.formatFilesAccordingToTypes(files: fileTypeArray)
    } catch let e {
      throw(e)
    }
    return container
  }
  
  class func getJSONFromData(_ fileData: Data) throws -> [[String: Any]] {
    var jsonDictionary = [[String: Any]]()
    do {
      jsonDictionary = try JSONSerialization.jsonObject(with: fileData, options: .mutableLeaves) as? [[String: Any]] ?? jsonDictionary
    } catch let e {
      throw(e)
    }
    return jsonDictionary
  }

  class func convertToFileType(withJSON json: [[String: Any]]) -> [File] {
    var fileTypeArray = [File]()
    for file in json {
      let fileType = File(type: file["Type"] as? String, size: file["Size"] as? Int, name: file["Name"] as? String, description: file["Description"] as? String)
      fileTypeArray.append(fileType)
    }
    return fileTypeArray
  }
  
  class func formatFilesAccordingToTypes(files: [File]) -> [FileContainer] {
    let audioArray = DataStore.filterFiles(from: files, with: FileType.Audios.allAudios)
    let videoArray = DataStore.filterFiles(from: files, with: FileType.Videos.allVideos)
    let executableArray = DataStore.filterFiles(from: files, with: FileType.Executables.allExecutables)
    let imageArray = DataStore.filterFiles(from: files, with: FileType.Images.allImages)
    // Creating Containers
    let audioContainer = FileContainer(typeIdentifier: "Audio's", files: audioArray)
    let videoContainer = FileContainer(typeIdentifier: "Video's", files: videoArray)
    let executableContainer = FileContainer(typeIdentifier: "Executable's", files: executableArray)
    let imageContainer = FileContainer(typeIdentifier: "Image's", files: imageArray)
    return [audioContainer, videoContainer, executableContainer, imageContainer]
  }
  
  class func filterFiles(from files: [File], with type: [String]) -> [File]{
    return files.filter { file in type.contains(where: { (str) -> Bool in
      file.type == str
    })}
  }
  
}
