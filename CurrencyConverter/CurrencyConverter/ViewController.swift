//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Erberk Yaman on 1.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func getRatesClickced(_ sender: UIButton) {
        
        //Request&Session
        
        let url = URL(string: "https://api.currencyapi.com/v3/latest?apikey=kEjw7WcgfgdSQCn20tWnK1wCuz4CsxQfXwCAXBbQ")
        
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Alert", message: error.debugDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                //Response&Data
                if data != nil {
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        
                        DispatchQueue.main.async{
                            
                            if let data = jsonResponse["data"] as? [String : Any] {
                                
                                if let gbp = data["GBP"] as? [String : Any] {
                                    
                                    if let gbpRate = gbp["value"] as? Double {
                                        
                                        self.gbpLabel.text = "GBP : \(gbpRate)"
                                    }
                                }
                                
                                if let jpy = data["JPY"] as? [String : Any] {
                                        
                                    if let jpyRate = jpy["value"] as? Double {
                                        
                                        self.jpyLabel.text = "JPY : \(jpyRate)"
                                    }
                                    
                                    }
                                
                                if let usd = data["USD"] as? [String : Any] {
                                        
                                    if let usdRate = usd["value"] as? Double {
                                        
                                        self.usdLabel.text = "USD : \(usdRate)"
                                    }
                                    
                                    }
                                
                                if let cad = data["CAD"] as? [String : Any] {
                                    
                                    if let cadRate = cad["value"] as? Double {
                                        
                                        self.cadLabel.text = "CAD : \(cadRate)"
                                    }
                                }
                                
                                if let TRY = data["TRY"] as? [String : Any] {
                                        
                                    if let tryRate = TRY["value"] as? Double {
                                        
                                        self.tryLabel.text = "TRY : \(tryRate)"
                                    }
                                    
                                    }
                            }
                            
                        }
                        
                    } catch {
                        print("error!")
                    }
                }
            }
        }
        task.resume()
        
    }
    
}

