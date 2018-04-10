//
//  page2.swift
//  Weather
//
//  Created by Fhict on 06/04/2018.
//  Copyright © 2018 Fhict. All rights reserved.
//

import UIKit

class page2: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var SweaterLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        getWeather()
        
        // get the Sweater label to change on different temperature (in progress)
        
      

    }
  
    
    
  
 

    
    
    func getWeather() {
        let session = URLSession.shared
        let weatherURL = URL(string:"http://api.openweathermap.org/data/2.5/weather?q=Eindhoven,nl?&units=metric&APPID=56e50d469acfcb85c13b6f21f210b413")!
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj!.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp_min") as? Int {
                                DispatchQueue.main.async {
                                    self.testLabel.text = "\(temperature)°C"
                                }
                                if temperature > 10{
                                    self.SweaterLabel.text = "Today is going to be very sunny. It would not hurt to wear sunglasses. Short clothes are recommended. Don't forget sunscreen."
                                }
                                if temperature < 10{
                                    self.SweaterLabel.text = "Make sure you're dressed against the cold. Pick yourself a warm sweater. You might want to take gloves with you aswell"
                                }
                            }
                        } else {
                            print("Error: unable to find temperature in dictionary")
                        }
                    } else {
                        print("Error: unable to convert json data")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        
      
        dataTask.resume()
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
