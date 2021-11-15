//
//  PlanetDetailsVC.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import UIKit
import RxSwift
import RxCocoa

class PlanetDetailsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var orbitalPeriodLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Variables
    fileprivate let bag = DisposeBag()
    let vm = PlanetDetailsVM()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addObservers()
    }
    
    // MARK: - Functions
    
    func setupUI() {
        backView.addLayerEffects(cornerRadius: 15)
        backView.addShadow()
    }
    
    func addObservers() {
        vm.name.asObservable()
            .bind(to: nameLabel.rx.text)
            .disposed(by: bag)
        
        vm.gravity.asObservable()
            .bind(to: gravityLabel.rx.text)
            .disposed(by: bag)
        
        vm.orbitalPeriod.asObservable()
            .bind(to: orbitalPeriodLabel.rx.text)
            .disposed(by: bag)
        
        vm.planetImage.asObservable()
            .bind(to: imageView.rx.image)
            .disposed(by: bag)
        
        btnCancel.rx.tap
            .subscribe() {[weak self] event in
                self?.pressedCancel()
            }
            .disposed(by: bag)
    }
    
    func pressedCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
