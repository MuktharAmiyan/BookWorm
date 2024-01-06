//
//  DetailView.swift
//  BookWorm
//
//  Created by Mukthar Amiyan on 29/10/23.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    let book : Book
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTACY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5 , y: -5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline )
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete",role:.destructive, action:deleteBook)
            Button("Cancel", role: .cancel) {}
        }message: {
            Text("Are you sure?")
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    showingDeleteAlert = true
                }label:{
                  Label("Delete this book", systemImage: "trash")
                }
            }
        }
    }
    
    func deleteBook () {
        moc.delete(book)
        
//        try? moc.save()
        dismiss()
    }
}

//#Preview {
//    DetailView()
//}
