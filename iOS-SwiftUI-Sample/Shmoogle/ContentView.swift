//
//  ContentView.swift
//  Shmoogle
//
//  Created by Tehila rozin on 19/09/2022.
//

import SwiftUI
import GenesysCloud

struct ChatView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        return ShmoogViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //code
        
    }
}


struct ContentView: View {
    @State var showingChat = false
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(.sRGB, red: 255/255, green: 79/255, blue: 30/255))
                    .frame(height: 30)
                    .clipped()
                Text("GeneBank")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                    .clipped()
                    .background(Color(.sRGB, red: 255/255, green: 79/255, blue: 30/255))
                    .font(Font.system(.largeTitle, design: .rounded).weight(.bold))
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 20)
                .clipped()
            Text("Customer Support")
                .padding()
                .font(Font.system(.title, design: .rounded).weight(.semibold))
                .foregroundColor(Color.white)
                .shadow(color: Color(.sRGBLinear, red: 0/255, green: 0/255, blue: 0/255).opacity(0.5), radius: 8, x: 0, y: 4)
            Text("For Customer Service, Please call at: \n+1-202-555-0130")
                .padding()
                .font(Font.system(.body, design: .rounded).weight(.semibold))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
                .frame(height: 40)
                .clipped()
            Text("OR")
                .font(Font.system(.title, design: .rounded).weight(.light))
            Spacer()
                .frame(height: 40)
                .clipped()
            
            Button {
                showingChat = true
            } label: {
                Text("Chat With Us!")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(.sRGB, red: 255/255, green: 79/255, blue: 30/255)), alignment: .center)
                    .foregroundColor(Color.white)
                    .font(Font.system(.body, design: .rounded).weight(.bold))
            }.fullScreenCover(isPresented: $showingChat) {
                ChatView().edgesIgnoringSafeArea(.vertical)
            }
            
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(Color(.sRGB, red: 255/255, green: 79/255, blue: 30/255).opacity(0.5)).ignoresSafeArea(), alignment: .center)
        .ignoresSafeArea()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
