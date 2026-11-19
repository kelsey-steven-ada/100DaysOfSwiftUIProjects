import Playgrounds


#Playground {
    func returnRandom(fromArray numbers: [Int]?) -> Int {
        return numbers?.randomElement() ?? Int.random(in: 1...100)
    }
}

