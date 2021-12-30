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
    @IBOutlet weak var severe: UILabel!
    @IBOutlet weak var dischargeLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView()
    }
    
    func mainView(){
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
    }
    
    
    

}

