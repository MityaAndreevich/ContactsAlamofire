//
//  ContactsTableViewController.swift
//  ContactsAlamofire
//
//  Created by Dmitry Logachev on 19.01.2022.
//

import UIKit

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
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? DetailedViewController else { return }
        detailedVC.contactDetails = sender as? Contact
    }
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = randomContacts[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: contact )
    }
}
    
extension ContactsTableViewController {
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
}

