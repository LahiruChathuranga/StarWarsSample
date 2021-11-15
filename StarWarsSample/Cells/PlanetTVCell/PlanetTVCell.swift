//
//  PlanetTVCell.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import UIKit
import RxSwift
import AlamofireImage

class PlanetTVCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetClimateLabel: UILabel!
    
    
    // MARK: - Variables
    let vm = PlanetTVCellVM()
    fileprivate let bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        planetImageView.af.setImage(withURL: URL(string: "https://picsum.photos/200")!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        planetImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func addObservers() {
        vm.name.asObservable()
            .bind(to: planetNameLabel.rx.text)
            .disposed(by: bag)
        
        vm.planetClimate.asObservable()
            .bind(to: planetClimateLabel.rx.text)
            .disposed(by: bag)
    }
}
