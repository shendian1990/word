import UIKit

struct Root: Codable{
    let root: String
    let index: Int
    let configure: Configure
    let words: [Word]
    
    struct Configure: Codable {
        let vowelRoot: [Int]
        let vowelExplain: [Int]
        let firstRoot: [Int]
        let firstExplain: [Int]
        let secondRoot: [Int]
        let secondExplain: [Int]
        let thirdRoot: [Int]
        let thirdExplain: [Int]
        let change: String
    }
}

struct Word: Codable{
    let name: String
    let cellType: Int
    let prefix: String
    let postfix: String
    let explain: String
}

func dataFromFile(_ filename: String)-> [Root]{
    var roots: [Root]?
    if let path = Bundle.main.path(forResource: filename, ofType: "json"){
        do{
            let jsonData = try String(contentsOfFile: path).data(using: .utf8)
            roots = try! JSONDecoder().decode([Root].self, from: jsonData!)
            print(roots![0].words[0].explain)
        } catch {
            print("\(filename) can't be parse:", error.localizedDescription)
        }
    }
    return roots!
}

//var roots = dataFromFile("test")

