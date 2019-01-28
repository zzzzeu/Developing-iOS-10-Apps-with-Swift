//methods can throw errors
class Context {
    func save() throws { }
}

let context = Context()
do {
    try context.save()
} catch let error {
    // can go looking in its documentation and see what kind of NSError stuff it can throw, decide what to do
    throw error // this would re-throw the error(only ok if the method we are in throws
}

//try! context.save()
//let x = try? errorProneFunctionThatReturnsAnInt(), x will be Int?
