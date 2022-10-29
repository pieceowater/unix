//
//  ContentView.swift
//  unix
//
//  Created by yury mid on 29.10.2022.
//

import SwiftUI
import Foundation
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var timerString: String = String(Int(NSDate().timeIntervalSince1970))
    @State private var humanReadableDate: String = " "
    @State private var numberToConverToTime: String = String(Int(NSDate().timeIntervalSince1970))
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var resultIsShowing: Bool = false
    @State private var resultCaption: String = ""
    @State private var convertedResult: String = ""
    @State private var datePickerTime: Date = Date.now
    @State private var sheetAboutUnix: Bool = false
    var body: some View {
            VStack {
                headerBlock
                currentTimeBlock
                if (resultIsShowing){
                    Button {
                        UIPasteboard.general.setValue(convertedResult, forPasteboardType: UTType.plainText.identifier)
                    } label: {
                        convertedResultBlock
                    }
                }
                unixToHumanReadableConverterBlock
                humanReadableToUnixConverterBlock
                
                    
                Spacer()
                infoButtonBlock
            }
            .padding()
            .background(Color.bg)
            .onTapGesture {
                self.endEditing()
            }
            .sheet(isPresented: $sheetAboutUnix) {
                AboutUnixView()
            }
    }
    
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var headerBlock: some View {
        HStack(alignment: .center){
            Text("UNIX")
                .tracking(10)
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom)
    }
    
    var currentTimeBlock: some View {
        VStack{
            Text("Current epoch time is")
            Button {
                UIPasteboard.general.setValue(timerString, forPasteboardType: UTType.plainText.identifier)
            } label: {
                Text(self.timerString)
                    .font(Font.system(.largeTitle, design: .monospaced))
                    .onReceive(timer) { _ in
                        timerString = String(Int(NSDate().timeIntervalSince1970))
                        humanReadableDate = unixTimeConverter(ts: Double(timerString) ?? 0.0)
                    }
            }
            
            Text(self.humanReadableDate)
        }
        .padding(.bottom)
    }
    
    var unixToHumanReadableConverterBlock: some View{
        ZStack{
            VStack(alignment: .leading){
                Text("Unix to human readable date")
                    .font(.headline)
                    .padding(4)
                
                TextField("Unix to convert...", text: $numberToConverToTime)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .padding(.horizontal,5)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.bottom)
                    .onTapGesture {}
                
                Button {
                    showResult(isUnixToDate: true)
                } label: {
                    HStack{
                        Text("Convert")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.accentColor)
                    .padding(10)
                    .padding(.horizontal,5)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(10)
                }

            }
            .foregroundColor(Color.accentColor)
            .padding()
            .background(.clear)
            .cornerRadius(15)
            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.accentColor.opacity(0.2), lineWidth: 2)
                )
            .padding(1)
        }
    }
    
    var humanReadableToUnixConverterBlock: some View{
        ZStack{
            VStack(alignment: .leading){
                Text("Date & Time to unix")
                    .font(.headline)
                    .padding(4)

                DatePicker("Select",selection: $datePickerTime)
                    .padding(.bottom)
                
                Button {
                    showResult(isUnixToDate: false)
                } label: {
                    HStack{
                        Text("Convert")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.accentColor)
                    .padding(10)
                    .padding(.horizontal,5)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(10)
                }

            }
            .foregroundColor(Color.accentColor)
            .padding()
            .background(.clear)
            .cornerRadius(15)
            .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.accentColor.opacity(0.2), lineWidth: 2)
                )
            .padding(1)
        }
    }
    
    func showResult(isUnixToDate: Bool = true){
        resultIsShowing = true
        if (isUnixToDate) {
            resultCaption = "Date from unix is"
            convertedResult = unixTimeConverter(ts: Double(numberToConverToTime) ?? 0.0)
        }else{
            resultCaption = "Unix timestamp from your date is"
            convertedResult = String(Int(datePickerTime.millisecondsSince1970))
        }
        
    }
    
    var convertedResultBlock: some View{
        ZStack{
            VStack(alignment: .leading){
                Text(resultCaption)
                    .font(.headline)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                
                Text(convertedResult)
                    .font(Font.system(.title2))
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(Color.accentColor)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .padding(1)
        }
    }
    
    func unixTimeConverter(ts: Double)->String{
        let date = NSDate(timeIntervalSince1970: ts)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm:ss a"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    var infoButtonBlock: some View {
        Button {
            sheetAboutUnix = true
        } label: {
            ZStack{
                HStack{
                    Text("About Unix-Time")
                    Spacer()
                    HStack{
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15,height: 15)
                    }
                    .font(.title2)
                }
                .foregroundColor(Color.accentColor)
                .padding()
                .background(.clear)
                .cornerRadius(15)
                .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.accentColor.opacity(0.3), lineWidth: 2)
                    )
                .padding(1)
            }
        }
    }
}
