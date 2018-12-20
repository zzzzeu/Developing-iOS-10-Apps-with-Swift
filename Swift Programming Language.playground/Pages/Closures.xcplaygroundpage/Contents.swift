func changeSign(operand: Double) -> Double { return -operand }

// could use it instead of sqrt
var operation: (Double) -> Double   // Function Type
operation = changeSign
let result = operation(4.0) // result will be -4.0

// can " in line" changeSign simply bby moving the function(without its name) below
operation = (operand: Double) -> Double { return -operand }

// a minor syntactic change: Move the first { to the start and replace with in
operation = { (operand: Double) -> Double in return -operand }

// Swift can infer that operation returns a Double and operand is a Double
operation = { (operand) in return -operand }

// it also knows that operation returns a value, so the return keyword is unnecessary
operation = {(operand) in -operand }

// it'll let you replace the parameter names with $0, $1, &2,etc.,and skip in
operation = { -$0 }

let primes = [2.0, 3.0, 5.0, 7.0, 11.0]
let negativePrimes = primes.map({ -$0 }) // [-2.0, -3.0...]
let invertedPrimes = primes.map() { 1.0/ $0 } // [0.5, 0.333...]
let primeString = primes.map { String($0) } // ["2.0", "3.0"...]
// if the last (or only) argument to a method is a colsure,
// you can put it outside the method's parentheses that contain its arguments
//  and if the closure was the only argument, skip the () completely if you want
