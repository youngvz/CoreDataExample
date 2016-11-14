//
//  AddLocationViewController.swift
//  CoreDataExample
//
//  Created by Viraj Shah on 11/14/16.
//  Copyright © 2016 VetekConsutling. All rights reserved.
//

import UIKit


class AddLocationViewController: UIViewController {
    
    
    
    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Location", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(addLocation), for: .touchUpInside)
        //btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func addLocation(){

        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let location = Location(context: context)
        location.name = "Location test"
        location.xcoordinate = "123231.34134"
        location.ycoordinate = "123421431.432"
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        view.backgroundColor = .white
    }
    
    func setupViews(){
        view.addSubview(addButton)
        
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
