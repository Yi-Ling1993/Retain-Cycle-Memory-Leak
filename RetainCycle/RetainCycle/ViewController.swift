//
//  ViewController.swift
//  RetainCycle
//
//  Created by 劉奕伶 on 2018/8/30.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

protocol SendDataDelegate: class {}

class ViewController: UIViewController {
    
    
    @IBAction func button(_ sender: Any) {
        
        normal()
    }
    
    @IBAction func delegate(_ sender: Any) {
        
        throughDelegate()
    }
    
    @IBAction func closure(_ sender: Any) {
        
        throughClosure()
    }
    
    func normal() {
        var gavin: People? = People(name: "Gavin", macbook: nil)
        var computer: Macbook? = Macbook(name: "Matilda", owner: nil)
        
        gavin?.macbook = computer
        computer?.owner = gavin
        
        gavin = nil
        computer = nil
    }
    
    func throughDelegate() {
        
        var secondVc: SecondVC? = SecondVC()
        
        secondVc = nil
    }
    
    func throughClosure() {
        
        var para: Element? = Element(name: "sign", text: "Hola amigos mio")
        
        let content = para?.someFunction()
        
        para = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class People {
    let name: String
    var macbook: Macbook?
    
    init(name: String, macbook: Macbook?) {
        self.name = name
        self.macbook = macbook
    }
    
    deinit {
        print("\(name) is being deinitialized.")
    }
}

class Macbook {
    let name: String
    var owner: People?
    
    init(name: String, owner: People?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
        print("Macbook named \(name) is being deinitialized.")
    }
}

class Element {
    
    let name: String
    let text: String
    
    lazy var someFunction: () -> String = { [weak self] in
        
        return "The \(self?.name) says \(self?.text)"
    }
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deallocated")
    }
    
}

class FirstVC {
    
   weak var delegate: SendDataDelegate?
    
}

class SecondVC: SendDataDelegate {
    
    lazy var firstVc = FirstVC()

    init() {
        
        print("hi")
         firstVc.delegate = self
    }
    
    deinit {
        print("In delegate, I'm done")
    }
}

















