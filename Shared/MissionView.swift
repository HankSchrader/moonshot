//
//  MissionView.swift
//  Moonshot
//
//  Created by Erik Mikac on 3/25/21.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var mission: Mission
    let astronauts: [CrewMember]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                        
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) {
                        crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 63)
                                        .clipShape(Circle())
                                        .overlay(Circle()
                                                    .stroke(Color.primary, lineWidth: 1))
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(crewMember.role == "Commander" ? .green : .secondary)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                                }
                        .buttonStyle(PlainButtonStyle())
                        }
                    
                    Spacer(minLength: 25)
                }
            }
        }
    }
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {
                                                $0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missin \(member)")
            }
        }
        self.astronauts = matches
        
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}