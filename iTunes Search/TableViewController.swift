//
//  TableViewController.swift
//  iTunes Search
//
//  Created by Denis Bystruev on 17/02/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Songs.load(url: "https://itunes.apple.com/search?term=swift") { songs in
            self.songs = songs
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let result = songs[indexPath.row]
        
        cell.textLabel?.text = result.artistName
        cell.detailTextLabel?.text = result.trackName
        
        Songs.loadImage(url: result.artworkUrl100) { image in
            
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
}
