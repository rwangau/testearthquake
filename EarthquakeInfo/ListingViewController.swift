//
//  ListingViewController.swift
//  EarthquakeInfo
//
//  Created by RUI WANG on 17/04/2017.
//  Copyright © 2017 Rui Wang. All rights reserved.
//

import UIKit

/**
    Description: This is the landing screen for showing latest earthquake events
    Tapping on a list itesm will open the map screen with the selected earthquake in focus
 */
class ListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var eventHandler: ListingEventHandler = ListingEventHandler()
    
    let tableView: UITableView = {
        let tView = UITableView(frame: CGRect.zero, style: .plain)
        
        return tView
    }()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshScreen), for: .valueChanged)
        
        eventHandler.loadData { 
            self.tableView.reloadData()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableView.frame = self.view.bounds
    }
    
    
    //MARK: tableview datasource & delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventHandler.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let identifier = "text_details_cell"
        
        cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        }
        
        if let object = eventHandler.object(at: indexPath){
            cell?.textLabel?.text = object.region
            cell?.detailTextLabel?.text = object.timedate
        }
        
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapVC = MapViewController()
        self.navigationController?.pushViewController(mapVC, animated: true)
        
        mapVC.eventHandler = self.eventHandler
        if let object = eventHandler.object(at: indexPath){
            mapVC.selectedEarthquakeModel = object
        }
        
    }
    
    
    //MARK: refresh control
    
    func refreshScreen(){
        eventHandler.loadData {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    
}
