//
//  RequestViewModel.swift
//  Bitcoin Value
//
//  Created by Vinicius Rezende on 11/01/23.
//

import Foundation

struct cripto{
    let lastValue:Double
    let buyValue:Double
    let sellValue:Double
    let symbol:String
    enum CodingKeys: String, CodingKey {
        case lastValue = "last"
        case buyValue = "buy"
        case sellValue = "sell"
        case symbol
    }
    init(lastValue: Double, buyValue: Double, sellValue: Double, symbol: String) {
        self.lastValue = lastValue
        self.buyValue = buyValue
        self.sellValue = sellValue
        self.symbol = symbol
    }
    
    
}
class RequestViewModel{
    var returnRequest: [cripto] = []
   
    func getDados(completion: @escaping ([cripto]) -> Void) {
        var listOfCripto:[cripto] = []
        let listOfOptionCripto:[String] = ["USD","AUD","BRL","CAD","CHF","CLP","CNY","DKK","EUR","GBP","HKD","INR","ISK","JPY","KRW","NZD","PLN","RUB"]
        
        if let requestUrl = URL(string: "https://blockchain.info/ticker") {
            let request = URLSession.shared.dataTask(with: requestUrl) { (data, request, error) in
                if error != nil{
                    debugPrint(error as Any)
                }else{
                    if let returnData = data{
                        do{
                            if let objectJson =  try JSONSerialization.jsonObject(with: returnData,options: []) as? [String: Any] {
                                listOfOptionCripto.forEach { content in
                                    if let brl = objectJson[content] as? [String: Any] {
                                        let lastValue = brl[cripto.CodingKeys.lastValue.rawValue] as? Double
                                        let buyValue = brl[cripto.CodingKeys.buyValue.rawValue] as? Double
                                        let sellValue = brl[cripto.CodingKeys.sellValue.rawValue] as? Double
                                        let symbol = brl[cripto.CodingKeys.symbol.rawValue] as? String
                                        
                                        let coin = cripto(lastValue: lastValue!, buyValue: buyValue!, sellValue: sellValue!, symbol: symbol!)
                                        listOfCripto.append(coin)
                                    }
                                }
                                if listOfCripto != nil {
                                    self.returnRequest = listOfCripto
                                    print(self.returnRequest)
                                    completion(self.returnRequest)
                                    
                                }
                            }
                            
                        }catch{
                            print(error)
                        }
                    }
                }
            }
            request.resume()
        }
        
    }
        
    
    
}
