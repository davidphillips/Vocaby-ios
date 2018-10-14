//
//  MainViewController.swift
//  Vocaby
//
//  Created by David Phillips on 4/8/18.
//  Copyright © 2018 David Phillips. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, VocabyAlertViewDelegate {
    
    @IBOutlet weak var wordOfTheDayView: UIView!
    @IBOutlet weak var wordOfTheDayLabel: UILabel!
    @IBOutlet weak var wordsTableView: UITableView!
    
    var wordArray: [VocabyWord] = []
    
    // MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wordOfTheDayView.backgroundColor = UIColor.vocabyLightRed()
        
        //testCall()
        rxTest()
    }
    
    func rxTest() {
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(0.3, scheduler: scheduler)
            .subscribe { event in
                print(event)
        }
        
        Thread.sleep(forTimeInterval: 2.0)
        
        subscription.dispose()
    }
    
    func testCall() {
        let appId = getAppId()
        let appKey = getAppKey()
        let language = "en"
        let word = "apple"
        let word_id = word.lowercased() //word id is case sensitive and lowercase is required
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(word_id)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
            print(String("Response: \(response)"))
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    print("Converting...")
                    print("json: \(json["results"] as? [String : Any])")
                    if let results = json["results"] as? [String : Any] {
                        let id = results["id"]
                        print("test id: \(id)")
                    }
                    else {
                        print("nil")
                    }
              
                }
            }
            catch {
                
            }
            
        })
        
        task.resume()
    }
    
    private func getAppId() -> String {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = keys {
            if let appId = dict["appId"] as? String {
                return appId
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }
    
    private func getAppKey() -> String {
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = keys {
            if let appKey = dict["appKey"] as? String {
                return appKey
            }
            else {
                return ""
            }
        }
        else {
            return ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func addWord() {
        let alert = VocabyAlertView(title: "Add a word")
        alert.delegate = self
        alert.show(animated: true)
    }
    
    // MARK: - VocabyAlertViewDelegate
    
    func onButtonPress(_ vocabyAlertView: VocabyAlertView) {
        if vocabyAlertView.textField.text != nil && vocabyAlertView.textField.text! != "" {
            print("word: \(vocabyAlertView.textField.text!)")
            wordArray.append(VocabyWord.init(word: vocabyAlertView.textField.text!, partOfSpeech: nil, definition: nil, dateAdded: Date()))
            wordsTableView.reloadData()
        }
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = wordArray.reversed()[indexPath.row].word
        return cell
    }


}

