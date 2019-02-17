//
//  Songs.swift
//  iTunes Search
//
//  Created by Denis Bystruev on 17/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

struct Songs: Codable {
    let results: [Song]
    
    static func load(url: String, completion: @escaping ([Song]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            guard let results = try? decoder.decode(Songs.self, from: data) else { return }
            
            completion(results.results)
        }.resume()
    }
    
    static func loadImage(url: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            completion(image)
        }.resume()
    }
}

struct Song: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String
}
