//
//  ProductListViewController.swift
//  MVVMPracticePrejoct
//
//  Created by Digitalflake on 23/01/25.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    
    
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        configuratipon()
    }
    
}
extension ProductListViewController {
    func configuratipon(){
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    //Data binding event observe kareega - comminucation hoga
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self =  self else { return }
            
            switch event{
            case .loading:
                print("Data Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data Loaded")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                    }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as?  ProductListTableViewCell else {
            return UITableViewCell()
        }
        let product =  viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
}
