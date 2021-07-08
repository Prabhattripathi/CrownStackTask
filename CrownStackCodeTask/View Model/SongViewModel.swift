//
//  SongViewModel.swift
//  CrownStackCodeTask
//
//  Created by Prabhat on 08/07/21.
//

import Foundation

struct SongViewModel {
 
  func fetchSongData(completion: @escaping(SongModel, Error?)->()) {
    guard let url = URL(string: "https://itunes.apple.com/search?term=Michael+jackson") else {return}
    URLSession.shared.songModelTask(with: url) { (songmo, response, err) in
      completion(songmo!, err)
    }.resume()
  }
}

