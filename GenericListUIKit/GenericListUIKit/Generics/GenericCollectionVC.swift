//
//  GenericCollectionVC.swift
//  GenericListUIKit
//
//  Created by MRhimi on 18/4/2023.
//

import UIKit
import Combine

class GenericCollectionVC<T: GenericCollectionViewCell<U>, U>: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    private let viewModel : GenericViewModel<U>
    
    private var cancellables = Set<AnyCancellable>()
    
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionViewLayout)
    
    var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return layout
    }()
    
    var itemSize: CGSize = CGSize.zero {
        didSet {
            collectionViewLayout.itemSize = itemSize
        }
    }
    
    var scrollDirection: UICollectionView.ScrollDirection = .vertical {
        didSet {
            collectionViewLayout.scrollDirection = scrollDirection
        }
    }
    
    init(viewModel: GenericViewModel<U>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    var emptyTitleString: String?
    var emptyDetailString: String?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindViewModel()
        makeConstraintCollectionView()
        
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = false
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.keyboardDismissMode = .onDrag
    }
    
    
    func makeConstraintCollectionView() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$itemsList
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else{return}
                self.collectionView.reloadData()
            })
            .store(in: &cancellables)
        
        viewModel.fetchItems()
    }
    
    
    func showDetails(with item: U){
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { return UICollectionViewCell() }
        let item = viewModel.cellForItem(at: indexPath)
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.didSelectItem(at: indexPath)
        showDetails(with: item)
    }

   
}
