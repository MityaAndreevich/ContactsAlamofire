//
//  DetailedViewController.swift
//  ContactsAlamofire
//
//  Created by Dmitry Logachev on 19.01.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var contactImageView: UIImageView! {
        didSet {
            contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
        }
    }
    
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var headerSurname: UILabel!
    @IBOutlet weak var contactSurnameLabel: UILabel!
    
    var result: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerName.text = "Name:"
        headerName.textColor = UIColor.blue
        headerSurname.text = "Surname:"
        headerSurname.textColor = UIColor.blue
    }


}

