//
//  dividirCuenta.swift
//  TipEase
//
//  Created by Alumno on 4/11/23.
//

import SwiftUI

struct dividirCuenta: View {
    @State private var tipoCuentaSeleccionado = 0
    @State private var totalApagar = ""
    @State private var cantidadPersonas = ""
    @State private var propina = "0%"
    @State private var nombre = ""
    @State private var precio = ""

    var body: some View {
        VStack {
            Form {
                    Section(header: Text("Dividir una cuenta por igual").foregroundColor(.black)) {
                        TextField("Total a pagar", text: $totalApagar)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white.opacity(0.6))
                            .foregroundColor(.black)
                        
                        TextField("Cantidad de personas", text: $cantidadPersonas)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white.opacity(0.6))
                            .foregroundColor(.black)
                        
                        Picker("Propina", selection: $propina) {
                            Text("0%").tag("0%")
                            Text("10%").tag("10%")
                            Text("15%").tag("15%")
                        }
                    }
                    
                    Text("Total a pagar por persona: \(calcularTotalPorPersona())")
                        .font(.headline)
                        .foregroundColor(.black)

            }
            .background(Color(#colorLiteral(red: 0.741, green: 0.133, blue: 0.302, alpha: 1)))
            .foregroundColor(.white)
            .navigationBarTitle("Dividir Cuenta", displayMode: .inline)
        }
    }

    private func calcularTotalPorPersona() -> String {
        var total = 0.0
        var totalPersona = 0.0
        if let totalPagar = Double(totalApagar),
           let personas = Double(cantidadPersonas) {
            if propina == "0%" {
                total = totalPagar
            } else if propina == "10%" {
                total = (totalPagar + (totalPagar * 0.1))
            } else if propina == "15%" {
                total = (totalPagar + (totalPagar * 0.15))
            }
            totalPersona = total / personas
            return String(format: "%.2f $", totalPersona)
        } else {
            return "Ingresa datos"
        }
    }
}

struct dividirCuenta_Previews: PreviewProvider {
    static var previews: some View {
        dividirCuenta()
    }
}
