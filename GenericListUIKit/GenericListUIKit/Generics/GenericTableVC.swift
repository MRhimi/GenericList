//
//  GenericTableVC.swift
//  GenericListUIKit
//
//  Created by MRhimi on 18/4/2023.
//

import UIKit
import Combine

class GenericTableVC<T: GenericTableViewCell<U>, U>: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
     let viewModel : GenericViewModel<U>
    private var cancellables = Set<AnyCancellable>()
    
    let tableView = UITableView()
    
    init(viewModel: GenericViewModel<U>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var emptyTitleString: String?
    var emptyDetailString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
        makeConstraintTableView()
        
        viewModel.fetchItems()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func makeConstraintTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$itemsList
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else{return}
                
                self.tableView.reloadData()

            })
            .store(in: &cancellables)
        
        viewModel.fetchItems()
    }
    
    func showDetails(with item: U){
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else { return UITableViewCell() }
        let item = viewModel.cellForItem(at: indexPath)
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.didSelectItem(at: indexPath)
        showDetails(with: item)
    }
    
    
   
}
