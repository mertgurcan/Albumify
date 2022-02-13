//
//  Helper.swift
//  AlbumifyTests
//
//  Created by Mert Gürcan on 13.02.2022.
//

import Foundation
import XCTest
@testable import Albumify

class Helper {

    static func getData() -> Codable? {
        let data = readFile(fileName: "MockData")
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(AlbumList.self, from: data.data(using:.utf8)!)
        } catch {
            XCTFail("Cant Decode")
        }
        return nil
    }

    static func readFile(fileName: String) -> String {
        let bundle = Bundle(for: self)
        if let filepath = bundle.path(forResource: fileName, ofType: "txt") {
            do {
                let str = try String(contentsOfFile: filepath)
                return str
            } catch {
                print("Data could not be loaded.")
            }
        } else {
            print("\(fileName).txt not found.")
        }
        XCTFail("\(fileName).txt not found")
        return ""
    }
}
