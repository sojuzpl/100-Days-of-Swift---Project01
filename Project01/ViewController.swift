//
//  ViewController.swift
//  Project01
//
//  Created by Zbigniew Pietras on 19/02/2019.
//  Copyright © 2019 Zbigniew Pietras. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
//        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

        // wywalenie rozszerzenia w nazwie pliku
        let name = String(pictures[indexPath.row].split(separator: ".").first!)
        cell.textLabel?.text = name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // znalezienie indexu w tabeli wybranego obrazka
            if let position = pictures.index(of: pictures[indexPath.row]) {
                vc.selectedImageNumber = position
                vc.selectedImage = pictures[indexPath.row]
                vc.amountImages = pictures.count
            }
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
