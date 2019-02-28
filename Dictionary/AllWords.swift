import UIKit

struct AllWords: Codable {
    let etymology: [Roots]
    
    struct Roots: Codable {
        let index: Int
        let roots: [Root]
    }
    
    struct Root: Codable {
        let root: String
        let explain: String
        let configure: [Configure]
        let words: [Words]
    }
    
    struct Configure: Codable {
        let change: String
        let first: String
        let firstColorPosition: [Int]
        let second: String
        let secondColorPosition: [Int]
    }
    
    struct Words: Codable {
        let name: String
        let insertPosition: [Int]
        let prefix: String
        let postfix: String
        let explain: String
        let explainColorPosition: [Int]
        let definition: String
    }
}

func dataFromFile(_ filename: String)->AllWords?  {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    var jsonResponse: String?
    if let path = bundle.path(forResource: filename, ofType: "json") {
        do{
            jsonResponse = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            
        }catch _ as NSError{print("error")}
    }
    
    var allWords: AllWords?
    
    do{
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        if let data = jsonResponse?.data(using: .utf8){
            allWords = try jsonDecoder.decode(AllWords.self, from: data)
        }
    }catch{
        print("Something went horribly wrong:", error.localizedDescription)
    }
    return allWords
}

