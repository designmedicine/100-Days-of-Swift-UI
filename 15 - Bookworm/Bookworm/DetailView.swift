//
//  DetailView.swift
//  Bookworm
//
//  Created by Natasha Godwin on 6/17/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var viewContext // so item can be deleted
    @Environment(\.presentationMode) var presentationMode // to return to ContextView when an item has been deleted
    @State private var showingDeleteAlert = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Non-Fiction")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)

                    Text(self.book.genre?.uppercased() ?? "NON-FICTION")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure you want to delete this?"), primaryButton: .destructive(Text("Delete")) {
                self.deleteBook()
            }, secondaryButton: .cancel())
        }
    }
    
    func deleteBook() {
        viewContext.delete(book) // delete the book
        try? self.viewContext.save() // make the deletion permanent
        presentationMode.wrappedValue.dismiss() // return to parent view
    }
}

struct DetailView_Previews: PreviewProvider {
    // Create a temporary managed object context to create the book
    static let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: viewContext)
        book.title = "Test"
        book.author = "Author"
        book.genre = "Non-Fiction"
        book.rating = 4
        book.review = "This was excellent!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
