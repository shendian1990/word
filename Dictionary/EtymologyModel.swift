import UIKit

struct Etymology: Codable {
    let etymology: [Root]
    
    struct Root: Codable {
        let index: Int
        let root: String
        let explain: String
        let words: [Word]
    }
    
    struct Word: Codable {
        let name: String
        let pronunciation: String
        let defination: String
        let explain: String
    }
}

func dataFromFile(_ filename: String)->Etymology?  {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    var jsonResponse: String?
    if let path = bundle.path(forResource: filename, ofType: "json") {
        do{
            let jsonResponse = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            
        }catch _ as NSError{print("error")}
    }
    
    var etymology: Etymology?
    
    do{
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = jsonResponse?.data(using: .utf8){
            etymology = try jsonDecoder.decode(Etymology.self, from: data)
        }
    }catch{
        print("Something went horribly wrong:", error.localizedDescription)
    }
    return etymology
}

dataFromFile("Etymology")