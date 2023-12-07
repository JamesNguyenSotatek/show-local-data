//
//  DetailViewController.swift
//  show-local-data
//
//  Created by Thân Văn Thanh on 06/12/2023.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    
    private let dataSource: [DetailValue]
    private let navigationTitle: String
    
    init(dataSource: [DetailValue], title: String) {
        self.dataSource = dataSource
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        title = navigationTitle
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(cellType: DetailTableViewCell.self)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DetailTableViewCell.self)
        cell.configCell(dataSource[indexPath.row])
        
        return cell
    }
}
