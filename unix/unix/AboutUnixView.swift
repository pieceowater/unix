//
//  AboutUnixView.swift
//  unix
//
//  Created by yury mid on 29.10.2022.
//

import SwiftUI

struct AboutUnixView: View {
    let showingTimeCompare:[String] = ["minute","hour","day","week","month","year"]
    let timeDict:[String : Int] = [
        "minute":60,
        "hour":3600,
        "day":86400,
        "week":604800,
        "month":2629743,
        "year":31556926
    ]
    
    var body: some View {
        VStack{
            headerBlock
                .padding()
            ScrollView{
                contentBlock
                    .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
    }
}

struct AboutUnixView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUnixView()
    }
}

extension AboutUnixView {
    private var headerBlock: some View {
        VStack{
            Image(systemName: "timer")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.accentColor)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(100)
                .padding(.bottom)
            Text("UNIX TIME")
                .tracking(10)
                .font(.title3)
                .fontWeight(.bold)
        }
        .padding(.bottom)
    }
    
    private var contentBlock: some View {
        VStack(alignment: .leading){
            Text("What is Unix time (Unix epoch or POSIX time or Unix timestamp)")
                .font(.headline)
                .padding(.bottom)
            Text("UNIX-time or POSIX-time is a method of encoding time adopted in UNIX and other POSIX-compatible operating systems. The starting point is midnight (UTC) from December 31, 1969 to January 1, 1970, the time from this moment is called Unix Epoch.  UNIX time is consistent with UTC, in particular, when declaring leap seconds UTC, the corresponding second numbers are repeated.")
                .font(.caption)
                .padding(.bottom)
            Text("The method of storing time in the form of the number of seconds is very convenient to use when comparing dates (accurate to the second), as well as for storing dates: if necessary, they can be converted to any readable format. The date and time in this format also take up very little space (4 or 8 bytes, depending on the size of the machine word), so it is reasonable to use it to store large amounts of dates. Performance disadvantages can manifest themselves with very frequent access to date elements, such as the month number, etc. But in most cases, it is more efficient to store time as a single value, rather than a set of fields.")
                .font(.caption)
                .padding(.bottom)
            Text("Human readable time")
                .font(.headline)
                .padding(.bottom)
            VStack{
                ForEach(0 ..< showingTimeCompare.count) { key in
                    HStack{
                        Text("1 \(showingTimeCompare[key])")
                        Spacer()
                        Text("\(String(timeDict[showingTimeCompare[key]] ?? 0)) sec")
                    }
                    .padding(10)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(1)
                }
            }
            .padding(.bottom)
            Text("What is the Unixtime Converter tool for?")
                .font(.headline)
                .padding(.bottom)
            Text("This tool, first of all, will be useful for webmasters who constantly deal with large volumes of dates or often refer to their elements in their work. Using the Unixtime Converter tool, you can easily convert Unix time to a user-friendly date (and vice versa), find out the current Unix epoch time, and also get Unix time in various programming languages, DBMS and operating systems.")
                .font(.caption)
                .padding(.bottom)
            Text("Unix terminology")
                .font(.headline)
                .padding(.bottom)
            Text("So, Unix time (or POSIX time) is the number of seconds that have passed from midnight on January 1, 1970 to the present.")
                .font(.caption)
                .padding(.bottom)
            Text("Unix Timestamp is a fixed time, in other words, a specific date imprinted in a number.")
                .font(.caption)
                .padding(.bottom)
        }
    }
}
