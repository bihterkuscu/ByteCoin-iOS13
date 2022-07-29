//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

//Kural olarak, Swift protokolleri genellikle sınıfı/yapıyı içeren dosyaya yazılır. Yani delegate metoda vs. CoinManager buna örnek
protocol CoinManagerDelegate {
    
    //Protokolde uygulama olmadan method taslaklarını oluştur
    //Current classa referans da ilet
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct CoinManager {
    
    //Delegate method uygulamak zorunda kalacak isteğe bağlı bir temsilci oluştur
    // Fiyatı güncellediğimizde haberdar edebileceğimiz
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "88E567D5-D113-4897-9B0D-A013F50BACF4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        
        //Seçilen para birimini API key ile birlikte baseURL sonuna eklemek için urlStriing kullan
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        //urlStringde oluşturulan url açmak için
        if let url = URL(string: urlString) {
            
            //Default configuration ile yeni bir URLSession objesi oluştur
            let session = URLSession(configuration: .default)
            
            //URLSession için yeni data task oluştur
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                //Geri aldığımız verileri yazdırabilmek için String olarak biçimlendir
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        //Delegate (ViewController)deki delegate methodu çağır ve gerekli verileri ilet
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            
            //Sunuculardan veri almak için taskı başlat
            task.resume()
        }
    }
    func parseJSON(_ data: Data) -> Double? {
        
        //Create a JSONDecoder
        let decoder = JSONDecoder()
        do {
            
            //CoinData yapısını kullanarak dataların kodunu çöz
            let decodedData = try decoder.decode(CoinData.self, from: data)
            
            //kodu çözülen datalardan en son özelliği al
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        } catch {
            
            //Catch and print any errors.
            print(error)
            return nil
        }
    }
    
}
