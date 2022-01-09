//
//  MainViewController.swift
//  Covid-19-Japan
//
//  Created by 村岡海人 on 2021/12/30.
//

import UIKit

class MainViewController: UIViewController {

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
    //MARK: -View設定
    func mainView(){
        contentView.layer.cornerRadius = 30
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.5
        view.addSubview(contentView)
    }
    
    //MARK: -API
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
    
    //MARK: -webView
    @IBAction func webView(_ sender: Any) {
        performSegue(withIdentifier: "goWeb", sender: self)
    }
    
    //MARK: -健康管理
    @IBAction func healthCheck(_ sender: Any) {
        
        print("健康管理をタップ")
        performSegue(withIdentifier: "goHelthCheck", sender: self)
    }
    
    //MARK: -県別状況
    @IBAction func chart(_ sender: Any) {
        print("県別状況をタップ")
        performSegue(withIdentifier: "goChart", sender: self)
    }

}

