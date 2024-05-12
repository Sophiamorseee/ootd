//
//  CalendarView.swift
//  ootd
//
//  Created by Sophia Morse on 5/10/24.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @State private var isShowingEvents = false
    @State private var selectedDay: Day?
    
    var body: some View {
        VStack {
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .padding()
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text(selectedMonth().title)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                        ForEach(selectedMonth().days, id: \.self) { day in
                            Button(action: {
                                // Update selectedDate to reflect the selected day
                                selectedDate = day.date
                                
                                // Set the selected day and show events
                                selectedDay = day
                                isShowingEvents = true
                            }) {
                                Text("\(day.day)")
                                    .frame(width: 40, height: 40)
                                    .background(day.isToday ? Color.blue : .clear)
                                    .foregroundColor(day.isWeekend ? .red : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $isShowingEvents, content: {
            if let selectedDay = selectedDay {
                NavigationView {
                    EventListView(selectedDay: selectedDay)
                        .navigationBarTitle(Text("Events"), displayMode: .inline)
                }
            }
        })
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private func selectedMonth() -> Month {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        
        guard let monthStartDate = calendar.date(from: DateComponents(year: year, month: month, day: 1)) else {
            fatalError("Unable to get start date of selected month")
        }
        guard let monthEndDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: monthStartDate) else {
            fatalError("Unable to get end date of selected month")
        }
        
        var days: [Day] = []
        calendar.enumerateDates(startingAfter: monthStartDate, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else { return }
            if date <= monthEndDate {
                let isToday = calendar.isDateInToday(date)
                let isWeekend = calendar.isDateInWeekend(date)
                days.append(Day(day: calendar.component(.day, from: date), date: date, isToday: isToday, isWeekend: isWeekend))
            } else {
                stop = true
            }
        }
        
        return Month(title: calendar.monthSymbols[month - 1], days: days)
    }
}

struct Day: Hashable {
    let day: Int
    let date: Date
    let isToday: Bool
    let isWeekend: Bool
}

struct Month: Hashable {
    let title: String
    let days: [Day]
}

struct EventListView: View {
    let selectedDay: Day
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Events for \(selectedDay.date, formatter: dateFormatter)")
                .font(.title)
                .padding()
            
            // Placeholder for event list
            ScrollView {
                ForEach(1...5, id: \.self) { index in
                    Text("Event \(index)")
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.blue)
                .imageScale(.large)
        })
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}
