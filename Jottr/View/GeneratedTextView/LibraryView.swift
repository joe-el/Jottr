//
//  LibraryView.swift
//  Jottr
//
//  Created by Kenneth Gutierrez on 9/9/22.
//

import SwiftUI

struct LibraryView: View {
    // MARK: Properties
    
    @EnvironmentObject var textGeneration: TextGeneration
    // have form dismiss itself
    @Environment(\.dismiss) var dismiss
    @State private var isShowingAccountScreen = false
    @State private var isShowingLoginScreen = false
    @State private var isShowingPromptEditorScreen = false
    @State private var isShowingSearchScreen = false
    @State private var isShowingStoryListView = false
    
    @State private var isHidden: Bool = false
   
    @State private var genre = ""
    @State private var review = ""
    
//    @State private var image: Image = Image("noImagePlaceholder")
//    @State private var inputImage: UIImage?
//    @State private var showingImagePicker = false
    
    // defines a date formatter and uses it to make sure a task date is presented in human-readable form:
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
        }()
    let currentDate = Date()
    
    let genres = [" Fantasy and Science Fiction", "Horror", "Children’s Fiction", "Mystery", "Romance", "Thriller"]
    
    var body: some View {
        Form {
            Section {
                // a link to a list of stories
                NavigationLink {
                    ContentView(currentView: LoadingState.storyList)
                } label: {
                    Label("Your Narratives", systemImage: "archivebox")
                        .font(.custom("Futura", size: 13))
                }
                .buttonStyle(.plain)
                
                // a link to a list of premises written by the user
                NavigationLink {
                    ContentView(currentView: LoadingState.storyList) //.animation(.easeInOut
                } label: {
                    Label("Most Recent", systemImage: "deskclock")
                        .font(.custom("Futura", size: 13))
                }// "as of \(currentDate - 604800, formatter: Self.taskDateFormat)"
                .buttonStyle(.plain)
                
                // a link to a list of stories the user recently deleted
                NavigationLink {
//                    self.currentView = .storyList
//                    StoryListView()
                } label: {
                    Label("Trash", systemImage: "trash")
                        .font(.custom("Futura", size: 13))
                }
                .buttonStyle(.plain)
            }
            
            Section {
                if !isHidden {
                    Text("Intro")
//                    image
//                        .resizable()
//                        .scaledToFit()
                }
                
//                Button("Save Image") {
//                    guard let inputImage = inputImage else { return }
//
//                    let imageSaver = ImageSaver()
//                    imageSaver.writeToPhotoAlbum(image: inputImage)
//                }
            } header: {
                HStack {
                    Text("INTRODUCTION")
                        .font(.system(.caption, design: .serif))
    //                        .frame(maxWidth: .infinity, alignment: .leading)
    //                        .padding([.top, .bottom], 5)
                    
                    Spacer()
                    
                    HideSectionView(isHidden: $isHidden)
                }
            }
            
//            Section {
//                Button("Save") {
                // add the book
//                    let newBook = Book(context: moc)
//                    newBook.id = UUID()
//                    newBook.title = title
//                    newBook.author = author
//                    newBook.rating = Int16(rating)
//                    newBook.genre = genre
//                    newBook.review = review
//
//                    try? moc.save()
//                    dismiss()
//                }
//            }
        } // MARK: Form Modyfiers
        .transition(.opacity)
        .navigationTitle("🖋Jottr") //highlighter
        .toolbar {
            ItemsToolbar(showingPromptEditorScreen: $isShowingPromptEditorScreen, showingLoginScreen: $isShowingLoginScreen, showingSearchScreen: $isShowingSearchScreen)
        }
//        .onChange(of: inputImage) { _ in loadImage() }
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .padding([.trailing], 25)
                Button {
                    isShowingSearchScreen.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.original)
                        .font(.headline)
                        .padding([.trailing], 25)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Show Search")
            }
        }
        .sheet(isPresented: $isShowingPromptEditorScreen) { PromptEditorView() }
        .sheet(isPresented: $isShowingLoginScreen) { LoginView() }
        .sheet(isPresented: $isShowingSearchScreen) { SearchView() }
//        .sheet(isPresented: $showingImagePicker) { ImagePicker(image: $inputImage) }
        }
    
    /*
     A method we can call when that property changes. Remember, we can’t use a plain property
     observer here because Swift will ignore changes to the binding, so instead we’ll write a
     method that checks whether inputImage has a value, and if it does uses it to assign a new
     Image view to the image property.
     */
//    func loadImage() {
//        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
//    }
}
