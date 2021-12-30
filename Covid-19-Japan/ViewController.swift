//
//  ViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2021/12/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var pcrLabel: UILabel!
    @IBOutlet weak var hospitalizeLabel: UILabel!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var severeLabel: UILabel!
    @IBOutlet weak var dischargeLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView()
        setUpAPI(parentView: contentView)
    }
    
    func mainView(){
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
    }
    
    func setUpAPI(parentView: UIView){
        CovidAPI.getTotal(completion: {(result: CovidInfo.Total) -> Void in
            DispatchQueue.main.async {
                self.pcrLabel.text = "\(result.pcr)"
                self.hospitalizeLabel.text = "\(result.hospitalize)"
                self.positiveLabel.text = "\(result.positive)"
                self.severeLabel.text = "\(result.severe)"
                self.dischargeLabel.text = "\(result.discharge)"
                self.deathLabel.text = "\(result.death)"
            }
        })
    }

}

