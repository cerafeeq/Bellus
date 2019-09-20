//
//  CategoryListVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

struct Category: Decodable {
    let id: Int
    let name: String
    let key: String
    let image: String

}

class CategoryListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var categories: [Category]!
    let prodListSegueId = "ProductList"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = NSLocalizedString("Categories", comment: "Navigation header title")
        label.textColor = UIColor(rgb: 0xEE269B)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        self.navigationItem.titleView = label
        
        guard let path = Bundle.main.path(forResource: "categories", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            
            categories = try JSONDecoder().decode([Category].self, from: data)
            
            //print(categories)
        }
        catch let error {
            print("parse error:\(error.localizedDescription)")
        }
        
    }

    // MARK: - Table view data source
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryListCell
        let category = categories[indexPath.row]
        
        cell.nameLbl.text = category.name
        cell.photo.image = UIImage(named: category.image)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == prodListSegueId,
            let destination = segue.destination as? ProductListVC,
            let catIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.category = categories[catIndex].key
        }
    }
}
