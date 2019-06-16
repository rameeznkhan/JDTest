//
//  FileType.swift
//  JDTestApp
//
//  Created by Rameez khan  on 16/06/19.
//  Copyright © 2019 Rameez khan . All rights reserved.
//

import Foundation
enum FileType {
  enum Images: String {
    case png
    case jpg
    static let allImages = [Images.png.rawValue, Images.jpg.rawValue]
  }
  
  enum Executables: String {
    case exe
    case dll
    static let allExecutables = [Executables.exe.rawValue, Executables.dll.rawValue]
  }
  
  enum Audios: String {
    case mp3
    case wav
    static let allAudios = [Audios.mp3.rawValue, Audios.wav.rawValue]
  }
  
  enum Videos: String {
    case avi
    case mpg
    static let allVideos = [Videos.mpg.rawValue, Videos.avi.rawValue]
  }
}
