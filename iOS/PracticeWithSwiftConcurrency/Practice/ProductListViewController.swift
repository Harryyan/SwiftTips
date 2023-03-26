//
//  ViewController.swift
//  Practice
//
//  Created by Harry Yan on 18/07/22.
//

import UIKit
import Combine

final class ProductListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // Need router to do this
    private let viewModel = ProductListViewModel(usecase: ProductUseCase(repository: ProductListRepository(loader: DataLoader())))
    private var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubscription()
        
        tableView.tableFooterView = UIView()
        
        viewModel.loadData()
        
    }
    
    private func setUpSubscription() {
        subscription = viewModel
            .$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.items.count == 0 ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = viewModel.items[indexPath.row].title
        cell.contentConfiguration = config
        
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
