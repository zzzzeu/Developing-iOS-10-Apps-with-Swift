//enum Optional<T> { // a generic type, like Array<Element> or Dictionary<Key, Value>
//    case none
//    case some<T> // the some case has associated data of type T
//}

var hello1: String? // var hello1: Optional<String> = .none
var hello2: String? = "hello" // var hello2: Optional<String> = .some("hello")
var hello3: String? = nil // var hello3: Optional<String> = .none

var hello4: String!
hello4 = ""
print(hello4)

var hello5: [Int]!
hello5 = []
print(hello5)

let x: String? = ""
let y = x ?? "foo"
//switch x {
//case .none:
//    y = "foo"
//case .some(let data):
//    y = data
//}

let a: String? = ""
//let b = a?.foo()?.bar?.c
//switch a {
//case .none:
//    b = nil
//case .some(let data1):
//    switch data1.foo() {
//    case .none:
//        b = nil
//    case .some(let data2):
//        switch data2.bar {
//        case .none:
//            b = nil
//        case .some(let data3):
//            b = data3.c
//        }
//    }
//}
