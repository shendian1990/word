import UIKit

let jsonResponse = """
{
"etymology":[
{
"index": 1,
"root": "acid",
"explain": "酸的，含酸的",
"words":[
{
"name": "acid",
"pronunciation": "",
"defination": "酸的，酸味的",
"explain": "",
"example": ""
},
{
"name": "acidify",
"pronunciation": "a",
"defination": "使......酸化，变酸",
"explain": "",
"example": ""
}
]
},
{
"index": 2,
"root": "cub",
"explain": "躺",
"words":[
{
"name": "concubine",
"pronunciation": "",
"defination": "情妇",
"explain": "",
"exampleSentence": ""
},
{
"name": "incubate",
"pronunciation": "",
"defination": "孵化",
"explain": "",
"exampleSentence": ""
}
]
}
]
}
"""

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

var etymology: Etymology?

do{
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    if let data = jsonResponse.data(using: .utf8){
        etymology = try jsonDecoder.decode(Etymology.self, from: data)
    }
}catch{
    print("Something went horribly wrong:", error.localizedDescription)
}

print(etymology)