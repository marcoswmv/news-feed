//
//  BaseDataSource.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

class BaseDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private(set) var tableView: UITableView
    var onError: ((_ error: Error) -> Void)?
    var onLoading: ((_ error: Error) -> Void)?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        setup()
    }
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func reload() {
        fatalError("Not implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Not implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Not implemented")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}
