//
//  ProductListVC.swift
//  Bellus
//
//  Created by Rafeeq Ebrahim on 02/12/18.
//  Copyright © 2018 Rafeeq Ebrahim. All rights reserved.
//

import UIKit

struct Product: Decodable {
    let id: Int
    let name: String
    let price: String
    let image: String
    let currency: String
    let description: String
}

class ProductListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var category: String!
    
    var products: [Product]!
    
    let prodDetailsSegueId = "ProductDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Products", comment: "Navigation header title")

        guard let path = Bundle.main.path(forResource: category, ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            
            products = try JSONDecoder().decode([Product].self, from: data)
        }
        catch let error {
            print("parse error:\(error.localizedDescription)")
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductListCell
        let product = products[indexPath.row]
        
        cell.lblName.text = product.name
        cell.imgProduct.image = UIImage(named: product.image)
        cell.lblPrice.text = product.currency + product.price
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == prodDetailsSegueId,
            let destination = segue.destination as? ProductDetailsVC,
            let index = tableView.indexPathForSelectedRow?.row
        {
            destination.product = products[index]
        }
    }
}
