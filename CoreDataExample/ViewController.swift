//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Viraj Shah on 11/14/16.
//  Copyright © 2016 VetekConsutling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var locations = [Location]()
    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let location = locations[indexPath.row]
        
        cell.textLabel?.text = location.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        
        if editingStyle == .delete {
            
            let location = locations[indexPath.row]
            context.delete(location)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                locations = try context.fetch(Location.fetchRequest())

            }catch{
                print("Fetch failed")
            }
        }
        tableView.reloadData()
    }
    
    
    func getData(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            locations = try context.fetch(Location.fetchRequest())
        }catch{
            print("Fetch failed")
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        setupNavbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getData()
        
        tableView.reloadData()
        
    }
    


    func setupViews(){
        view.addSubview(tableView)
        
        // ios 9 constraints
        // x,y,width, height
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        
    }

    func setupNavbar(){
        navigationItem.title = "Locations"

        let addLocationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        
        addLocationButton.tintColor = .black
        
        navigationItem.rightBarButtonItems =  [addLocationButton]

    }
    
    let addLocationVC = AddLocationViewController()
    
    func addLocation(){
        navigationController?.pushViewController(addLocationVC, animated: true)
    }
    
    
}

