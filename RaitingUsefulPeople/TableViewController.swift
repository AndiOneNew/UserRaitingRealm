//
//  TableViewController.swift
//  RaitingUsefulPeople
//
//  Created by Илья Новиков on 10.11.2021.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    var person: Results<Person>!
    let realm = try! Realm()
    let cellLabel = TableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        person = realm.objects(Person.self)
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    @IBAction func addPerson(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Create new person", message: "", preferredStyle: .alert)
        alert.addTextField(){ textFieldEmail in
            textFieldEmail.placeholder = "Enter email..."
            textFieldEmail.keyboardType = .emailAddress
        }
        alert.addTextField(){ textField in
            textField.placeholder = "Enter description person..."
        }
        alert.addTextField(){ textFieldRaiting in
            textFieldRaiting.placeholder = "Enter raiting person..."
            textFieldRaiting.keyboardType = .numberPad
        }
        let create = UIAlertAction(title: "Create", style: .cancel) { (action) in
            guard let textFieldEmail = alert.textFields?[0], let emailPersonSave = textFieldEmail.text else { return }
            guard let textFieldDescription = alert.textFields?[1], let descriptionPersonSave = textFieldDescription.text else { return }
            guard let textFieldRaiting = alert.textFields?[2], let raitingPersonSave = textFieldRaiting.text else { return }
            let newPerson = Person(emailPerson: emailPersonSave, descriptionPerson: descriptionPersonSave, rating: Int(raitingPersonSave))
            self.save(newPerson)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(create)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
//    func updatePerson (_ model: Person){
//        let alert = UIAlertController(title: "Update person", message: "", preferredStyle: .alert)
//
//        alert.addTextField(){ textFieldEmail in
//            textFieldEmail.placeholder = model.emailLabel
//            textFieldEmail.keyboardType = .emailAddress
//        }
//        alert.addTextField(){ textField in
//            textField.placeholder = model.descriptoinsLabel
//        }
//        alert.addTextField(){ textFieldRaiting in
//            textFieldRaiting.placeholder = model.raitingString()
//            textFieldRaiting.keyboardType = .numberPad
//        }
//        let update = UIAlertAction(title: "Update", style: .cancel) { (action) in
//            guard let textFieldEmail = alert.textFields?[0], let emailPersonSave = textFieldEmail.text else { return }
//            guard let textFieldDescription = alert.textFields?[1], let descriptionPersonSave = textFieldDescription.text else { return }
//            guard let textFieldRaiting = alert.textFields?[2], let raitingPersonSave = textFieldRaiting.text else { return }
//            let updatePerson = Person(emailPerson: emailPersonSave, descriptionPerson: descriptionPersonSave, rating: Int(raitingPersonSave))
//            self.save(updatePerson)
//            self.tableView.reloadData()
//        }
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//        alert.addAction(update)
//        alert.addAction(cancel)
//        present(alert, animated: true)
//    }
    
    func save<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.add(object)
            }
        }catch{
            print("Cant create: \(error.localizedDescription)")
        }
    }
    func delete<T: Object>(_ object: T){
        do{
            try realm.write{
                realm.delete(object)
            }
        }catch{
            print("Cant create: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configureCell(with: person[indexPath.row])
        return cell
    }
    
    // MARK: - Table view delegate
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let somePerson = person[indexPath.row]
            delete(somePerson)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        updatePerson(updatePerson)
//    }
}
