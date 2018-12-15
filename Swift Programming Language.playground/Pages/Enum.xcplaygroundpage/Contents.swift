enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie
    
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
        case .hamburger(let pattyCount):
            return pattyCount == number
        case .fries, .cookie:
            return true // a drink and cookie in every special order
        case .drink(_, let ounces):
            return ounces == 16 // & 16oz drink of any kind
        }
    }
    
    var calories: Int {
        return 1000
        // caculate and return caloric value here
    }
    
    mutating func switchToBeingACookie() {
        self = .cookie
    }
}

enum FryOrderSize {
    case large
    case small
}

var menuItem = FastFoodMenuItem.fries(size: .large)

switch menuItem {
case .hamburger(let pattyCount):
    print("a burger with \(pattyCount) patties")
case .fries(let size):
    print("a \(size) order of fries")
case .drink(let brand, let ounces):
    print("a \(ounces)oz \(brand)")
case .cookie:
    print("a cookie!")
}

var otherItem: FastFoodMenuItem = .cookie

switch otherItem {
case .hamburger:
    break
case .fries:
    print("fries")
    print("yummy")
default:
    print("other")
}
