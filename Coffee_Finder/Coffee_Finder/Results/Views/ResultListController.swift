//
//  ViewController.swift
//  Coffee_Finder
//
//  Created by Steven Worrall on 6/8/20.
//  Copyright © 2020 Steven Worrall. All rights reserved.
//

import UIKit
import SnapKit

class ResultListController: UIViewController {
    private let foursquareInteractor = FoursquareInteractor()
    private var data: [Venue] = []
    
    private let cellID = "myCellID"
    
    private let tableView: UITableView = {
        let temp = UITableView(frame: .zero, style: UITableView.Style.plain)
        temp.backgroundColor = .clear
        temp.separatorStyle = .singleLine
        temp.tableFooterView = UIView()
        temp.rowHeight = UITableView.automaticDimension
        temp.estimatedRowHeight = UITableView.automaticDimension
        temp.allowsSelection = false
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupTableView()
        
        foursquareInteractor.delegate = self
        foursquareInteractor.getVenueDataWithPhotoURL()
        
    }

    private func setupView() {
        self.view.backgroundColor = .white
    }
    
    private func reloadViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension ResultListController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(ResultCell.self, forCellReuseIdentifier: self.cellID)

        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID) as! ResultCell
        let dataForCell = data[indexPath.row]
        
        cell.data = dataForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ResultListController: FoursquareInteractorDelegate {
    func dataSuccess(data: [Venue]) {
        self.data = data
        
        self.reloadViews()
    }
    
    func dataFailure(error: Error) {
        // TODO: Handle this in a better way if production app
        self.presentAlert(title: "Cannot retrieve data", message: error.localizedDescription)
    }
}
