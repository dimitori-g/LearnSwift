//
//  api.swift
//  LearnSwift
//
//  Created by arche1 on 2021/09/03.
//

import SwiftUI
import URLImage

struct Result: Codable{
    var items: [User]
}

struct User: Codable{
    public var login: String
    public var url: String
    public var avatar_url: String
    public var html_url: String
    }

class FetchUsers: ObservableObject {
@Published var items = [User]()
init() {
    let url = URL(string: "https://api.github.com/search/users?q=kanji")!
    URLSession.shared.dataTask(with: url) {(data, response, error) in
        do {
            if let data = data {
                let decodedData = try JSONDecoder().decode(Result.self, from:data)
                DispatchQueue.main.async {
                    self.items = decodedData.items
                }
            } else {
                print("No data")
            }
        } catch {
            print("Uknwonw error")
//print("Error: \(error.localizedDescription ?? "unknown error")")
        }
    }.resume()
    }
}

struct ApiView: View {
@ObservedObject var fetch = FetchUsers()
var body: some View {
    List(fetch.items, id: \.login) { user in
        HStack(alignment: .top) {
            URLImage(URL(string:user.avatar_url)!){ image in
                image.resizable().frame(width: 50, height: 50)
            }
        VStack(alignment: .leading) {
            Text(user.login)
            Text("\(user.url)")
                .font(.system(size: 11))
                .foregroundColor(Color.gray)
            }
        }}
    }
}

struct ApitView_Previews: PreviewProvider {
    static var previews: some View {
        ApiView()
    }
}
