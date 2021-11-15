//
//  PlanetListVC.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import UIKit
import RxSwift
import RxCocoa

class PlanetListVC: BaseVC {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {didSet{tableView.rx.setDelegate(self).disposed(by: bag)}}
    
    // MARK: - Variables
    fileprivate let bag = DisposeBag()
    fileprivate let vm = PlanetListVM()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        setupUI()
        addObservers()
        
        // get fist time data set
        proceedWithGetPlanetsAPIRequest(isLoadMore: false, page: "")
    }
    
    // MARK: - Functions
    
    func registerNibs() {
        tableView.register(UINib(nibName: .PlanetTVCell, bundle: Bundle.main), forCellReuseIdentifier: .PlanetTVCell)
    }
    
    func setupUI() {
        setUpRefreshing()
    }
    
    func setUpRefreshing() {
        let footer = self.configureLoadMoreFooter()
        
        let nextPage = getPageFromURL(urlString: vm.metaData?.next)
        
        if nextPage != nil {
            self.tableView.configRefreshFooter(with: footer, container: self) {
                self.delay(1.0, closure: {
                    self.tableView.switchRefreshFooter(to: .normal)
                    self.proceedWithGetPlanetsAPIRequest(isLoadMore: true, page: nextPage ?? "")
                    self.tableView.switchRefreshFooter(to: .removed)
                })
            }
        } else {
            self.tableView.switchRefreshFooter(to: .noMoreData)
        }
    }
    
    func addObservers() {
        vm.planetList.asObservable().bind(to: tableView.rx.items(cellIdentifier: .PlanetTVCell, cellType: PlanetTVCell.self)) { index, model, cell in
            cell.addObservers()
            cell.vm.configureCell(with: model)
        }
        .disposed(by: bag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.tableView.cellForRow(at: indexPath) as? PlanetTVCell {
                    self?.handleDidTapOnCell(with: indexPath.row, imageInfo: cell.planetImageView.image)
                }
            })
            .disposed(by: bag)
    }
    
    func handleDidTapOnCell(with index: Int, imageInfo: UIImage?) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: .PlanetDetailsVC) as! PlanetDetailsVC
        vc.vm.bindData(with: vm.planetList.value[index], imageInfo: imageInfo)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    // API Request
    func proceedWithGetPlanetsAPIRequest(isLoadMore: Bool, page: String) {
        if isLoadMore {
            vm.fetchPlanets(isLoadMore: isLoadMore, page: page) { staus in
                if !staus {
                    print("Error")
                } else {
                    self.setUpRefreshing()
                }
            }
        } else {
            startLoading()
            vm.fetchPlanets(isLoadMore: isLoadMore, page: page) { staus in
                self.stopLoading()
                if !staus {
                    print("Error")
                } else {
                    self.setUpRefreshing()
                }
            }
        }
    }
}
extension PlanetListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
