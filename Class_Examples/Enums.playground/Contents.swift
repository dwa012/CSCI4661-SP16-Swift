//: Playground - noun: a place where people can play

enum Lollipop {
    case Blue
    case Red
    case Green
    
    var text: String {
        switch self {
        case .Blue :
            return "I am blue!!!!"
        case .Red:
            return "I am red!!!!"
        case .Green:
            return "I am green!!!!"
        }
    }
    
    var shape: String {
        switch self {
        case .Blue, .Red :
            return "I am spherical"
        case .Green:
            return "I am square"
        }
    }
}


func echoLolli(input: Lollipop) -> String {
    return input.text
}

let l = Lollipop.Red

echoLolli(Lollipop.Blue)
echoLolli(Lollipop.Red)

Lollipop.Red.shape


