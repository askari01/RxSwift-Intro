//
//  ViewController.swift
//  RXSwift Intro
//
//  Created by Syed Askari on 9/11/17.
//  Copyright © 2017 Syed Askari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var resultTF: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Observable.combineLatest(firstTF.rx.text.orEmpty, secondTF.rx.text.orEmpty, thirdTF.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return ((Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0))
        }
            .map{ $0.description }
            .bind(to: resultTF.rx.text)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

