//
//  Person.swift
//  RaitingUsefulPeople
//
//  Created by Илья Новиков on 10.11.2021.
//

import Foundation
import RealmSwift


class Person: Object {
    
    @objc dynamic var emailLabel:String? = nil
    @objc dynamic var descriptoinsLabel:String? = nil
    let raitingLabel = RealmOptional<Int>()
    
    convenience init(emailPerson: String?, descriptionPerson: String?, rating: Int?) {
      self.init()
        emailLabel = emailPerson
        descriptoinsLabel = descriptionPerson
        raitingLabel.value = rating
    }
    
    func raitingString() -> String? {
      guard let value = raitingLabel.value else { return nil }
      return String(value) + "/10"
    }
}
