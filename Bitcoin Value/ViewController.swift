//
//  ViewController.swift
//  Bitcoin Value
//
//  Created by Vinicius Rezende on 11/01/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    public var coin: cripto?
    override func viewDidLoad() {
        super.viewDidLoad()
        symbol.text = coin?.symbol
        let nf = NumberFormatter()
        nf.numberStyle = .decimal

        nf.groupingSeparator = "."
        nf.decimalSeparator = ","

        if let sellValue = nf.string(from: NSNumber(value: coin!.sellValue)) {
            self.sellvalue.text =  "Sell value: R$ " + sellValue
        }
        if let buyValue = nf.string(from: NSNumber(value: coin!.buyValue)) {
            self.buyvalue.text = "buy value: R$ " + buyValue
        }
        if let lastValue = nf.string(from: NSNumber(value: coin!.lastValue)) {
            lastvalue.text = "Last value: R$ " + lastValue
        }
    }

    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var sellvalue: UILabel!
    @IBOutlet weak var buyvalue: UILabel!
    @IBOutlet weak var lastvalue: UILabel!
}

