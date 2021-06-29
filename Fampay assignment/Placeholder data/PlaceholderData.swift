//
//  PlaceholderData.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import Foundation

let whiteColor = try? HexColor(rawValue: "#ffffff")
let blackColor = try? HexColor(rawValue: "#000000")
let backgroundColor = try? HexColor(rawValue: "#454AA6")
let goldColor = try? HexColor(rawValue: "#FBAF03")

let cardData = ContextualCard(name: "Name",
                              formattedTitle: .init(text: "{} {}",
                                                    entities: [
                                                        .init(text: "Big Display card",
                                                              color: goldColor,
                                                              url: URL(string: "https://google.com"),
                                                              fontStyle: nil),
                                                        .init(text: "with Action",
                                                              color: whiteColor,
                                                              url: nil,
                                                              fontStyle: .italic)
                                                    ]),
                              fallbackTitle: "title",
                              formattedDescription: .init(text: "Small display", entities: []),
                              fallbackDescription: "This is a sample text for the subtitle that you can add to contextual cards",
                              icon: nil,
                              url: URL(string: "https://google.com"),
                              backgroundImage: .init(imageType: .external, assetType: nil, imageUrl: URL(string: "https://westeros-staging.s3.amazonaws.com/media/images/generic/2a650f966e1f4a2e81bdbbb118fb2e73.png")),
                              backgroundColor: backgroundColor,
                              backgroundGradient: nil,
                              cta: [
                                ContextualCardCTA(text: "Action", backgroundColor: blackColor, url: nil, textColor: whiteColor),
                                ContextualCardCTA(text: "Action", backgroundColor: blackColor, url: nil, textColor: whiteColor),
                              ]
)


import Foundation

let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    return jsonDecoder
}()

let path = Bundle.main.path(forResource: "sample_response", ofType: "json")
let data = FileManager.default.contents(atPath: path!)
var placeholderData = try! jsonDecoder.decode([ContextualCardGroup].self, from: data!).filter { $0.designType != .unsupported }
