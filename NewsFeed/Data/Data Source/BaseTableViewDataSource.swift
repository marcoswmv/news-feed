//
//  BaseDataSource.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

class BaseTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    private(set) var tableView: UITableView
    var onError: ((_ error: Error) -> Void)?
    var onLoading: ((_ isLoading: Bool) -> Void)?
    
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
        1
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
        0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
}
