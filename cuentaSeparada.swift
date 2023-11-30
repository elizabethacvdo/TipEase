//
//  cuentaSeparada.swift
//  TipEase
//
//  Created by Alumno on 4/11/23.
//

import SwiftUI

struct Item {
    var precio: String
}

struct DetalleCuenta {
    var nombre: String
    var totalIndividual: String
}

struct cuentaSeparada: View {
    @State private var nombre = ""
    @State private var precio = ""
    @State private var totalIndividual = ""
    @State private var totalGeneral = ""
    @State private var precios: [Item] = []
    @State private var detallesCuenta: [DetalleCuenta] = []

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Cuentas por separado").foregroundColor(.white)) {
                    TextField("Nombre", text: $nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white.opacity(0.6))
                        .foregroundColor(.black)
                        .keyboardType(.default)

                    List {
                        ForEach(precios, id: \.precio) { item in
                            Text(item.precio)
                        }
                    }

                    TextField("Precio", text: $precio)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white.opacity(0.6))
                        .foregroundColor(.black)
                        .keyboardType(.numberPad)

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

                    Text("Total Individual: \(totalIndividual)").foregroundColor(.white)
                }

                Button("Agregar otra cuenta") {
                    if !nombre.isEmpty {
                        detallesCuenta.append(DetalleCuenta(nombre: nombre, totalIndividual: totalIndividual))
                        precio = ""
                        calcularTotalIndividual()
                        precios.removeAll()
                        totalIndividual = ""
                    }
                }
                .disabled(nombre.isEmpty)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(#colorLiteral(red: 0.741, green: 0.133, blue: 0.302, alpha: 1)))
                .cornerRadius(10)

                List {
                    ForEach(detallesCuenta, id: \.nombre) { detalle in
                        Text("Nombre: \(detalle.nombre), Total Individual: $\(detalle.totalIndividual)")
                    }
                }
                .background(Color.white.opacity(0.6))
                .foregroundColor(.black)
            }
        }
    }

    // Función para calcular el total individual
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
}

struct cuentaSeparada_Previews: PreviewProvider {
    static var previews: some View {
        cuentaSeparada()
    }
}
