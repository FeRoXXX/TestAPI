//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Александр Федоткин on 27.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rubLable: UILabel!
    @IBOutlet weak var eurLable: UILabel!
    @IBOutlet weak var usdLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadDataClicked(_ sender: Any) {
        
        // Open URL
        // Response
        // Parsing
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=264170bea223f573fe36a79054681798")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else{
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                if let rub = rates["RUB"] as? Double{
                                    self.rubLable.text = "RUB: \(String(rub))"
                                }
                                if let eur = rates["EUR"] as? Double{
                                    self.eurLable.text = "EUR: \(String(eur))"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLable.text = "USD: \(String(usd))"
                                }
                            }
                        }
                    } catch{
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

