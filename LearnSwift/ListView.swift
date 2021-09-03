//
//  ListView.swift
//  LearnSwift
//
//  Created by arche1 on 2021/09/03.
//

import SwiftUI

struct ListView: View {
    @State private var todos = [
    Todo(name:"Write SwiftUI book",category: "work"),
    Todo(name:"Read Bible",category: "personal"),
    Todo(name:"Bring kids out to play",category: "family"),
    Todo(name:"Fetch wife",category: "family"),
    Todo(name:"Family",category: "Call mum")
    ]
    var body: some View {
        NavigationView {
            List {
                ForEach(todos, id:\.name) {(todo) in
                    NavigationLink(destination:
                        VStack{
                            Text(todo.name)
                            Text(todo.category).foregroundColor(Color.gray)
                        })
                    {
                        HStack {
                            Text(todo.name).bold()
                            Text(todo.category).foregroundColor(Color/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    todos.remove(atOffsets: indexSet)
                })
            }.navigationBarTitle("List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct Todo {
    let name: String
    let category: String
}
