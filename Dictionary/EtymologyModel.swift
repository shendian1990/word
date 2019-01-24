
public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

var wordIndex =0

class Etymology{
    var name: String?
    var explain: String?
    var words: [Word]()

    init?(data: Data){
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["Etymology"] as? [String: Any]{
                let index = body["index"] as? Int
                if(index == wordIndex){
                    self.name = body["name"] as? String
                    self.explain = body["explain"] as? String
                    if let words = body["words"] as [[String: Any]]{
                        self.words = words.map { Word(json: $0)}
                    }
                }
            }
        } catch{
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

class Word{
    var name: String?
    var pronunciation: String?
    var defination: String?
    var explain: String?
    var examplSentence: String?

    init(json: [String:Any]){
        self.name = json["name"] as? String
        self.pronunciation = json["pronunciation"] as? String
        self.defination = json["defination"] as? String
        self.explain = json["explain"] as? String
        self.examplSentence = json["examplSentence"] as? String
    }
}