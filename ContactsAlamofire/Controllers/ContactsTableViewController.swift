//
//  ContactsTableViewController.swift
//  ContactsAlamofire
//
//  Created by Dmitry Logachev on 19.01.2022.
//

import UIKit
import Alamofire

class ContactsTableViewController: UITableViewController {
    
    private var randomContacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        downloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = randomContacts[indexPath.row]
        if let imageURL = contact.picture?.thumbnail {
            NetworkManager.shared.fetchImage(from: imageURL) { imageData in
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            }
        }
        
        content.text = contact.name?.first
        content.secondaryText = contact.name?.last
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    private func downloadData() {
        NetworkManager.shared.fetchDataWithAlamofire(Link.linkFor50.rawValue) { result in
            switch result {
            case .success(let randomContacts):
                self.randomContacts = randomContacts
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

