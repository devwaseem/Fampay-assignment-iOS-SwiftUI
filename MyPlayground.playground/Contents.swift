import Foundation
import Combine
import PlaygroundSupport

//let jsonDecoder = JSONDecoder()
//jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

//let url = URL(string: "http://www.mocky.io/v2/5ed79368320000a0cc27498b")!
//FampayAPISimulator.shared.fetch(url: url)
//let path = Bundle.main.path(forResource: "sample_response", ofType: "json")
//let data = FileManager.default.contents(atPath: path!)
//let result = try! jsonDecoder.decode([ContextualCardGroup].self, from: data!)
//dump(result)



let input = "{Hello}{}, {},"
var sub = ["waseem", "akram"]

//let out = input.components(separatedBy: "{}").map { token -> String in
//    if sub.count != 0 {
//        return token + sub.removeFirst()
//    }
//
//    return token + "{}"
//}.joined().dropLast(2)

let comp = input.components(separatedBy: "{}")

//for (i, c) in comp.enumerated() {
//    if sub.count != 0 {
//        out += c + sub.removeFirst()
//        continue
//    }
//    if i == comp.count - 1 {
//        out += c
//        continue
//    }
//
//}

var out = comp.map { token -> String in
    if sub.count != 0 {
        return token + sub.removeFirst()
    }
    
    return token
}.joined()



print(out)
if var formattedTitle = cardData.formattedTitle {
    print(formattedTitle.getFilteredComponents())
    dump(formattedTitle.getParsedEntities())
}


PlaygroundPage.current.needsIndefiniteExecution = true
