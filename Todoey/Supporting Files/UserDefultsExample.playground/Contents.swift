import UIKit

let defaults = UserDefaults.standard // singleton the .standard is a singleton
let sharedURLSession = URLSession.shared // singleton the .shared is also a singleton

// only use defaults for small data changes. try and avoid using arrays or large arrays. User defaults are referred to as singletons

// create a constant for dictionary
let dictionaryKey = "myDictionary"

// standard data types you can use
defaults.set(0.24, forKey: "Volume")
defaults.set(true, forKey: "MusicOn")
defaults.set("Jamie", forKey: "PlayerName")
defaults.set(Date(), forKey: "AppLastOpenedByUser")

// for a fancy defaults option, create a collection:
let array = [1, 2, 3]
defaults.set(array, forKey: "myArray")

// the same example using dictionaries
let dictionary = ["name": "Jamie"]
//defaults.set(dictionary, forKey: "myDictionary")
defaults.set(dictionary, forKey: dictionaryKey) // using the constant to remove errors when typing and if you need to change your key you can change it one place


let volume = defaults.float(forKey: "Volume")
let appLastOpen = defaults.object(forKey: "AppLastOpenedByUser")

// call the colection
let myArray = defaults.array(forKey: "myArray") as! [Int] // down cast the array into integers

// call the dictionary
//let myDictionary = defaults.dictionary(forKey: "myDictionary")
let myDictionary = defaults.dictionary(forKey: dictionaryKey)
