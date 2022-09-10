//
//  ContentView.swift
//  UnitConversions
//
//  Created by igor s on 10.09.2022.
//

import SwiftUI

enum Unit: String, CaseIterable {
    case meters, kilometers, feet, miles
}

struct ContentView: View {
    @State private var unitValue: Double? = nil
    @State private var unitType = Unit.kilometers
    @State private var unitConversionType = Unit.meters
    
    @FocusState private var valueIsFocudes: Bool
    
    let unitTypes = Unit.allCases
    
    var result: Double {
        var result = 0.0
        
        if let value = unitValue {
            switch unitType {
            case .meters:
                result = value
            case .kilometers:
                result = value * 1000
            case .feet:
                result = value / 3.28084
            case .miles:
                result = value * 1609.34
            }
            
            switch unitConversionType {
            case .meters:
                result *= 1
            case .kilometers:
                result /= 1000
            case .feet:
                result *= 3.28084
            case .miles:
                result /= 1609.34
            }
        }
        return result
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Enter unit value", value: $unitValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocudes)
                    
                    Picker("Unit Type", selection: $unitType) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0.rawValue )
                        }
                    }
                } header: {
                    Text("Initial Data")
                }
                
                Section {
                    Picker("Unit Types", selection: $unitConversionType) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0.rawValue )
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to")
                }
                
                Section {
                    Text(String(
                        format:
                            "%.2f \(unitType.rawValue) is %.2f \(unitConversionType.rawValue)",
                        unitValue ?? 0.0, result)
                    )
                }
            }
            .navigationTitle("Unit Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueIsFocudes = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
