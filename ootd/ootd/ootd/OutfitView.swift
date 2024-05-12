//
//  OutfitView.swift
//  ootd
//
//  Created by Sophia Morse on 5/10/24.
//

import Foundation
import SwiftUI
import Foundation
import SwiftUI

struct OutfitView: View {
    let outfit: Outfit
    @State private var caption: String = ""
    @State private var comment: String = ""
    @State private var isLiked: Bool = false // Added state for like status
    @State private var showComments: Bool = false // Added state for showing comments sheet

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Profile Header
            HStack {
                // Profile Picture Icon
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.blue) // Change profile picture color
                
                // Profile Name
                Text(outfit.profileName)
                    .font(.custom("Ribbon", size: 16)) // Apply custom font here
                    .fontWeight(.bold)
                
                Spacer() // Spacer to push buttons to the right
            }
            .padding(.horizontal, 10)

            // Image
            Image(outfit.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            // Action Buttons (e.g., like, comment, share)
            HStack {
                Button(action: {
                    // Toggle like status when heart button is clicked
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? Color.blue : Color.black.opacity(0.4)) // Change heart color based on like status
                }
                .padding(8)
                
                Button(action: {
                    // Action for comment button
                    showComments.toggle()
                }) {
                    Image(systemName: "bubble.left")
                }
                .padding(8)
                
                Spacer()
                
                Button(action: {
                    // Action for share button
                }) {
                }
                .padding(8)
            }
            
            // Caption
            if !caption.isEmpty {
                Text(caption)
                    .font(.custom("Ribbon", size: 18)) // Apply custom font here
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
            }
            
            // Comments Section
            if showComments {
                // Comments sheet
                CommentSheet(isPresented: $showComments, outfitName: outfit.name)
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 10)
    }
}

struct CommentSheet: View {
    @Binding var isPresented: Bool
    let outfitName: String
    @State private var newComment: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .background(Color.white)
        
        // Comment input
        TextField("Enter your comment...", text: $newComment)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            .background(Color.white)
        
        // Divider
        Divider()
            .background(Color.black)
            .padding(.top, 8)
        
        // Submit button
        Button(action: {
            // Action for posting comment
            print("Posted comment: \(newComment)")
            isPresented.toggle()
        }) {
            Text("Post")
                .font(.custom("Ribbon", size: 16)) // Apply custom font here
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
        }
        .background(Color.white)
        
    }
    
}
