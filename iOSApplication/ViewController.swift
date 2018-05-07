//
//  ViewController.swift
//  iOSApplication
//
//  Created by Sundir Talari on 07/05/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    
    var SampleArr = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        table.delegate = self
        table.dataSource = self
        
        let url = URL(string: "https://trell.co.in/expresso/interestCategories.php")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data =  data else {return}
            
            do {
                
        let json = try JSONSerialization.jsonObject(with: data, options: []) as![String: Any]
                //print(json)
                //print((json)["status"]!)
                //print((json)["message"]!)
                //print((json)["categoriesArray"]!)
                let gettingJson = ((json)["categoriesArray"]!) as![Any]
                //print(((gettingJson)[0] as![String: Any])["categoryName"]!)
                let Calling = ((gettingJson)[0] as![String: Any])
               // print((Calling)["categoryImage"]!)
                self.SampleArr = gettingJson
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
                
            }catch {
                print("json error: \(error.localizedDescription)")
            }
            
        }.resume()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SampleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = ((SampleArr[indexPath.row] as![String: Any])["categoryName"] as! String)
        return cell!
    }


}

