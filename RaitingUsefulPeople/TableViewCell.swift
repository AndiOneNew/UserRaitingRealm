//
//  TableViewCell.swift
//  RaitingUsefulPeople
//
//  Created by Илья Новиков on 22.11.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var raitingLabel: UILabel!
    
    func configureCell(with model: Person){
        emailLabel.text = model.emailLabel
        descripLabel.text = model.descriptoinsLabel
        raitingLabel.text = model.raitingString()
    }
}
