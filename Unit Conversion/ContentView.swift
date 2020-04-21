//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Abhinav Mathur on 20/04/20.
//  Copyright © 2020 Abhinav Mathur. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    let temperatureUnits = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
//    @State private var inputUnit = 0
//    @State private var conversionUnit = 0
//    @State private var inputValue = ""
//    var output: Double {
//        let input = Double(inputValue) ?? 0.0
//        let calculatedValue = Measurement(value: input, unit: temperatureUnits[inputUnit])
//        let convertedValue = calculatedValue.converted(to: temperatureUnits[conversionUnit])
//        return convertedValue.value
//    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Input Unit")) {
//                    Picker("Input Measurment", selection: $inputUnit) {
//                        ForEach(0 ..< temperatureUnits.count) {
//                            Text("\(self.temperatureUnits[$0].symbol)")
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//
//                Section(header: Text("Output Unit")) {
//                    Picker("Output Measurment", selection: $conversionUnit) {
//                        ForEach(0 ..< temperatureUnits.count) {
//                            Text("\(self.temperatureUnits[$0].symbol)")
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//
//                Section {
//                    TextField("Input Temperature", text: $inputValue)
//                    .keyboardType(.decimalPad)
//                }
//
//                Section(header: Text("Output Temperature")) {
//                    Text("\(output)")
//                }
//            }
//            .navigationBarTitle(Text("Unit Conversion"))
//        }
//    }
//}

enum MeasurementType: String, CaseIterable {
    case temperature, length, time, volume

    public func measurementUnits() -> [Dimension] {
        switch self {
        case .temperature:
            return [UnitTemperature.celsius,
                    UnitTemperature.fahrenheit,
                    UnitTemperature.kelvin]
        case .length:
            return [UnitLength.meters,
                    UnitLength.kilometers,
                    UnitLength.feet,
                    UnitLength.yards,
                    UnitLength.miles]
        case .time:
            return [UnitDuration.seconds,
                    UnitDuration.minutes,
                    UnitDuration.hours]
        case .volume:
            return [UnitVolume.milliliters,
                    UnitVolume.liters,
                    UnitVolume.cups,
                    UnitVolume.pints,
                    UnitVolume.gallons]
        }
    }
}


struct ContentView: View {

    @State private var selectedMeasurement = 0
    @State private var inputUnit = 0
    @State private var conversionUnit = 0
    @State private var inputValue = ""
    private var measurement: MeasurementType {
        return MeasurementType.allCases[selectedMeasurement]
    }
    
    var output: Double {
        let input = Double(inputValue) ?? 0.0
        let calculatedValue = Measurement(value: input, unit: measurement.measurementUnits()[inputUnit])
        let convertedValue = calculatedValue.converted(to: measurement.measurementUnits()[conversionUnit])
        return convertedValue.value
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Measurement Unit")) {
                    Picker("Measurment Unit", selection: $selectedMeasurement) {
                        ForEach(0 ..< MeasurementType.allCases.count) {
                            Text("\(MeasurementType.allCases[$0].rawValue.capitalized)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Input Unit")) {
                    Picker("Measurment Input", selection: $inputUnit) {
                        ForEach(0 ..< measurement.measurementUnits().count) {
                            Text("\(self.measurement.measurementUnits()[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .id(selectedMeasurement)
                }
                Section(header: Text("Input Value")) {
                    TextField("Input \(self.measurement.rawValue)", text: $inputValue)
                    .keyboardType(.decimalPad)
                }
                Section(header: Text("Output Unit")) {
                    Picker("Measurment Output", selection: $conversionUnit) {
                        ForEach(0 ..< measurement.measurementUnits().count) {
                            Text("\(self.measurement.measurementUnits()[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .id(selectedMeasurement)
                }
                Section(header: Text("Output \(self.measurement.rawValue)")) {
                    Text("\(output, specifier: "%.2f") \(measurement.measurementUnits()[conversionUnit].symbol)")
                }
            }
            .navigationBarTitle(Text("Unit Conversion"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
