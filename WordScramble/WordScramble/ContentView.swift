//
//  ContentView.swift
//  WordScramble
//
//  Created by Natasha Godwin on 5/24/21.
//

import SwiftUI

/*
 
 Working with Lists
 
 List v. Form
 Both List and Form can contain a mix of static and dynamic data. However, there's one major difference:
 With List, you don't need to use ForEach to generate rows for dynamic data. (If you want to mix static and dynamic data, you'll still need to use ForEach)
 
 List(0..<5) {
   Text("Row \($0)")
 }
 
 Ids
 When generating a list from an array of strings or numbers, each item needs to have an id, regardless of whether you're using ForEach or List
 
 List(list, id: \.self) {
    Text($0)
 }
 
 ForEach(list, id: \.self) {
    Text($0)
 }
 
 .listStyle(GroupedListStyle())
 
 Working with Files
 
 Swift knows to look for images in the asset catalogue, but with other types of data, it gets more complicated.
 
 If you want to use data from an external file - JSON, TXT, CSV - there are more steps involved.
 
 Bundle
 All of the files for an iOS app are stored in one place: a bundle. It contains binary code (compiled Swift code), assets, extra files like JSON and TXT files, Info.plist, and more.
 
 URL
 A data type that can store the location of files.
 
 Bundle.main.url()
 This code is used to access files inside your main app bundle. This is an optional URL: if the file exists, you'll get it; if it doesn't, you'll get nil.
 
 if let fileURL = Bundle.main.url(forResource: "name-of-file", withExtension: "txt") {
   // success!
 }
 
 String(contentsOf:)
 Accepts a file URL and converts its contents into a string.
 
 Note that if the file can't be loaded, you'll get an error.
 
 if let fileContents = try? String(contentsOf: fileURL) {
   
 }
 
 Working with Strings
 
 iOS have powerful APIs for working with strings.
 
 components(separatedBy:)
 A method that converts a single string into an array of strings. Useful for converting text files into arrays of strings.
 
 .randomElement()
 A method that returns a random element from an array. Returns an optional string, so must be unwrapped or used with nil coalescing.
 
 .trimmingCharacters(in:)
 A method that is used to remove certain kinds of characters, usually whitespace and new lines, from the start and end of a string.
 
 UITextChecker
 A class that is used for spell check. Comes from UIKit and is written in Objective-C.
 
 There are four steps to using it.
 1. Create a word and an instance of UITextChecker to check it.
 
 let word = "word"
 let spellCheck = UITextChecker()
 
 2. Tell the checker how much of the string it needs to check.
 
 Swift and Objective-C, the language used to create UITextChecker, don't handle strings the same way. Because of that, you need to create an Objective-C string range using the entire length of your characters.
 
 let range = NSRange(location: 0, length: word.utf16.count)
 
3. Get the location of the misspellings
 
 let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
 
 4. Check for spelling mistakes
 
 Objective-C doesn't have optionals. Instead, it uses a special type called NSNotFound to represent missing data.
 
 So, to check for mistakes, you'll need to write this:
 
 let zeroMistakes = misspelledRange.location == NSNotFound
 
 
 
 
 */

struct ContentView: View {
    static let symptomsData =
        """
        brain fog
        concentration problems
        protruding neck veins
        chest pain
        muscle weakness
        bone pain
        """

    let symptoms = symptomsData.components(separatedBy: "\n")
    
    var body: some View {
        List {
            Section(header: Text("Symptoms")) {
                ForEach(symptoms, id: \.self) { symptom in
                    Text(symptom)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
