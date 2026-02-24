//
//  Cipher.swift
//  CipherKit
//
//  Created by Кирилл Зайцев on 24.02.2026.
//

import Foundation

let alphabet: [Character] = ["А","Б","В","Г","Д","Е","Ж","З","И","Й",
                              "К","Л","М","Н","О","П","Р","С","Т","У",
                              "Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э",
                              "Ю","Я"]

func shiftChar(char: Character, shift: Int) -> Character {
    if let index = alphabet.firstIndex(of: char) {
        let newChar = (shift + index) % 32
        let result = alphabet[newChar]
        return result
    }
    return char
}

protocol Chiper {
    func encrypt(text: String) -> String
    func dencrypt(text: String) -> String
}

struct CaesarCipher: Chiper {
    let shift: Int
    func encrypt(text: String) -> String {
        var encrypted = ""

        for char in text {
            let newChar = shiftChar(char: char, shift: shift)
            encrypted.append(newChar)
        }

        return encrypted
    }
    
    func dencrypt(text: String) -> String {
        var dencrypt = ""

        for char in text {
            let newChar = shiftChar(char: char, shift: 32 - shift)
            dencrypt.append(newChar)
        }
        return dencrypt
    }
}

struct VigenereCipher: Chiper {
    let key: String
    func encrypt(text: String) -> String {
        var encrypted = ""
        let keyChars = Array(key)
        var keyIndex = 0
        
        for char in text {
            let keyChar = keyChars[keyIndex]
            if let index = alphabet.firstIndex(of: keyChar) {
                let newChar = shiftChar(char: char, shift: index)
                keyIndex = (keyIndex + 1) % keyChars.count
                encrypted.append(newChar)
            }
        }
        return encrypted
    }
    
    func dencrypt(text: String) -> String {
        var dencrypt = ""
        let keyChars = Array(key)
        var keyIndex = 0
        
        for char in text {
            let keyChar = keyChars[keyIndex]
            if let index = alphabet.firstIndex(of: keyChar) {
                let newChar = shiftChar(char: char, shift: 32 - index)
                keyIndex = (keyIndex + 1) % keyChars.count
                dencrypt.append(newChar)
            }
        }
        return dencrypt
    }
}
