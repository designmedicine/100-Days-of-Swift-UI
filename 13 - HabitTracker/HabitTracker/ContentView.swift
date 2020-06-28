//
//  ContentView.swift
//  HabitTracker
//
//  Created by Natasha Godwin on 6/13/20.
//  Copyright © 2020 Natasha Godwin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var list = Habits()
    @State private var showingAddHabit = false
    var body: some View {
        NavigationView {
            List {
                ForEach(list.items) { item in
                    NavigationLink(destination: HabitDetail(habits: self.list, habitId: item.id)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(item.name)")
                                    .font(.headline)
                                Text("\(item.goal) \(item.unit) \(item.frequency)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("\(item.completedTimes)")
                                .font(.headline)
                                .foregroundColor(item.completedTimes > 0 ? .blue : .red)
                        }
                    }
                }
              .onDelete(perform: removeItem)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddHabit = true
            }){
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabit(habits: self.list)
        }
        .environmentObject(list)
    }
    
    func removeItem(at locations: IndexSet) {
        list.items.remove(atOffsets: locations)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}