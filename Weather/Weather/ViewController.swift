//
//  ViewController.swift
//  Weather
//
//  Created by Fhict on 05/04/2018.
//  Copyright © 2018 Fhict. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func onGoButton(_ sender: Any) {
        performSegue(withIdentifier: "mySegue" , sender: self)
    }
    
    
    @IBOutlet weak var weatherLabel2: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
   
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        
        getWeather()

    }
    
    
    
    @IBOutlet weak var labelTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getCurrentDateTime()

        getWeather2()
        getWeather()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let str = formatter.string(from: Date())
        labelTime.text = str
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
                            if let temperature = mainDictionary.value(forKey: "temp_min") {
                                DispatchQueue.main.async {
                                    self.weatherLabel.text = "\(temperature)°C"
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

    func getWeather2() {
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
                        if let mainDictionary = jsonObj!.value(forKey: "wind") as? NSDictionary {
                            if let status = mainDictionary.value(forKey: "speed") {
                                DispatchQueue.main.async {
                                    self.weatherLabel2.text = "Wind speed: \(status) km/h"
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
    
    
}



