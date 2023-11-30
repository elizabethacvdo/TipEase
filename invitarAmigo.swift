import SwiftUI

struct invitarAmigo: View {
    @State private var nombre = ""
    @State private var precio = ""
    @State private var totalIndividual = ""
    @State private var totalGeneral = ""
    @State private var precios: [Item] = []
    @State private var detallesCuenta: [DetalleCuenta] = []
    
    let colorPrincipal = Color(hex: "BD224D")
    let colorSecundario = Color(hex: "FFA200")
    let colorFondoFormulario = Color.white
    
    @State private var CantidadPersonas = ""
    @State private var totalIndividualAgregado = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Invitar a un amigo") .foregroundColor(colorPrincipal)) {
                    TextField("Nombre", text: $nombre)
                        .keyboardType(.default)
                        .foregroundColor(colorPrincipal)
                    
                    List {
                        ForEach(precios, id: \.precio) { item in
                            Text(item.precio)
                                .foregroundColor(colorPrincipal)
                        }
                    }
                    
                    TextField("Precio", text: $precio)
                        .keyboardType(.numberPad)
                        .foregroundColor(colorPrincipal)
                    
                    Button("Agregar") {
                        if !precio.isEmpty {
                            precios.append(Item(precio: precio))
                            precio = ""
                            calcularTotalIndividual()
                        }
                    }
                    .disabled(precio.isEmpty)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.741, green: 0.133, blue: 0.302, alpha: 1)))
                    .cornerRadius(10)
                    
                    Text("Total Individual: \(totalIndividual)")
                        .foregroundColor(colorPrincipal)
                }
                
                
                
                Button("Agregar otra cuenta") {
                    if !nombre.isEmpty {
                        detallesCuenta.append(DetalleCuenta(nombre: nombre, totalIndividual: totalIndividual))
                        precio = ""
                        calcularTotal()
                        precios.removeAll()
                        totalIndividual = ""
                    }
                }
                .disabled(CantidadPersonas.isEmpty)
                .disabled(nombre.isEmpty)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(#colorLiteral(red: 0.741, green: 0.133, blue: 0.302, alpha: 1)))
                .cornerRadius(10)
                
                TextField("Cantidad de personas: ", text: $CantidadPersonas)
                    .keyboardType(.numberPad)
                    .foregroundColor(colorPrincipal)
                
                Text("Total por persona: $\(totalIndividualAgregado)")
                    .foregroundColor(colorPrincipal)
            }
            .background(colorFondoFormulario) // Cambia el color del fondo del formulario aquí
        }
    }
                
    private func calcularTotalIndividual() {
        let total = precios.reduce(0) { (result, item) in
            if let precio = Double(item.precio) {
                return result + precio
            } else {
                return result
            }
        }
        totalIndividual = String(total)
    }
    
    private func calcularTotal() {
        var total = 0.0
        
        for detalle in detallesCuenta {
            total += Double(detalle.totalIndividual) ?? 0
        }
        totalIndividualAgregado = String(format: "%.2f", total / (Double(CantidadPersonas) ?? 0))
    }
}

struct invitarAmigo_Previews: PreviewProvider {
    static var previews: some View {
        invitarAmigo()
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
