import SwiftUI

struct AddOutfitView: View {
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var isEditingCaption = false
    @State private var caption = ""
    @State private var postedOutfit: Outfit? // Track the posted outfit
    @State private var currentDate = Date()
    @State private var selectedDate = Date()

    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                CalendarView(selectedDate: $selectedDate)
                    .padding(.bottom, 30)
                
                Spacer()
                
                Button(action: {
                    isShowingImagePicker.toggle()
                }) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.blue)
                        Text(getCurrentMonth())
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
                .edgesIgnoringSafeArea(.all)
                .onDisappear {
                    if selectedImage != nil {
                        isEditingCaption = true
                    }
                }
        }
        .sheet(isPresented: $isEditingCaption) {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                TextField("Enter caption", text: $caption)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Create a new outfit with the selected image
                    let newOutfit = Outfit(name: "New Outfit", imageName: "placeholder_outfit", profileName: "Your Profile")
                    // Set the posted outfit to trigger updating the parent view
                    postedOutfit = newOutfit
                    // Reset states
                    selectedImage = nil
                    isEditingCaption = false
                    caption = ""
                }) {
                    Text("Post")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("AddOutfit"))) { notification in
            if let newOutfit = notification.object as? Outfit {
                // Add the new outfit to the outfits array
                // You can handle adding to your profile here
            }
        }
    }
    
    func getCurrentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: currentDate)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}
