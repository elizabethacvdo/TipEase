import SwiftUI

struct ContentView: View {
    @State private var isShowingMenu = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 189 / 255, green: 34 / 255, blue: 77 / 255)
                    .edgesIgnoringSafeArea(.all)
                
                if isShowingMenu {
                    Color.black.opacity(0.5)
                        .onTapGesture {
                            withAnimation {
                                isShowingMenu.toggle()
                            }
                        }
                }

                HStack {
                    if isShowingMenu {
                        SidebarMenu()
                            .frame(width: 250)
                            .transition(.move(edge: .leading))
                    }

                    VStack {
                        Image("1")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("")
            .navigationBarItems(leading:
                Button(action: {
                    withAnimation {
                        isShowingMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color.white) // Color para el botón
                }
            )
            .environment(\.horizontalSizeClass, .compact)
        }
    }
}

struct SidebarMenu: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: dividirCuenta()) {
                    Label("Dividir Cuenta", systemImage: "")
                        .foregroundColor(Color.black)
                }

                NavigationLink(destination: cuentaSeparada()) {
                    Label("Cuentas Separadas", systemImage: "")
                        .foregroundColor(Color.black)
                }

                NavigationLink(destination: invitarAmigo()) {
                    Label("Invitar a un amigo", systemImage: "")
                        .foregroundColor(Color.black) // Color para los textos
                }

          //      NavigationLink(destination: Text("Acerca de")) {
          //          Label("Acerca de", systemImage: "")
          //              .foregroundColor(Color.black) // Color para los textos
           //     }
            }
        }
        .listStyle(SidebarListStyle())
        .background( Color(red: 189 / 255, green: 34 / 255, blue: 77 / 255))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
