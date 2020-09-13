/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

// MARK:- Reusable SFSymbol Images
enum LibrarySymbol {
  case bookmark
  case bookmarkFill
  case book
  case letterSquare(letter: Character?)
  
  var image: UIImage {
    let imageName: String
    switch self {
    case .bookmark, .book:
      imageName = "\(self)"
    case .bookmarkFill:
      imageName = "bookmark.fill"
    case .letterSquare(let letter):
      guard
        let letter = letter?.lowercased(),
        let image = UIImage(systemName: "\(letter).square")
      else {
        imageName = "square"
        break
      }
      return image
    }
    return UIImage(systemName: imageName)!
  }
}

// MARK:- Library
enum Library {
  static let books: [Book] = [
    Book(title: "Ein Neues Land", author: "Shaun Tan"),
    Book(title: "Bosch", author: "Laurinda Dixon"),
    Book(title: "Dare to Lead", author: "Brené Brown"),
    Book(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet"),
    Book(title: "Drinking with the Saints", author: "Michael P. Foley"),
    Book(title: "A Guide to Tea", author: "Adagio Teas"),
    Book(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson"),
    Book(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
    Book(title: "How to Draw Cats", author: "Janet Rancan"),
    Book(title: "Drawing People", author: "Barbara Bradley"),
    Book(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
  ]
  
  static func saveImage(_ image: UIImage, forBook book: Book) {
    let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
    if let jpgData = image.jpegData(compressionQuality: 0.7) {
      try? jpgData.write(to: imageURL, options: .atomicWrite)
    }
  }
  
  static func loadImage(forBook book: Book) -> UIImage? {
    let imageURL = FileManager.documentDirectoryURL.appendingPathComponent(book.title)
    return UIImage(contentsOfFile: imageURL.path)
  }
}


extension FileManager {
  static var documentDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}

