green_day = Project.create({ name: 'Green Day', genre: 'Alternative' })

american_idiot = Setlist.create({ title: 'American Idiot', location: 'Canada', time: '2004-09-20 00:00:00', project_id: 1 })

american_idiot_tracklist = Song.create([
  { title: 'American Idiot', length: 174, project_id: 1},
  { title: 'Jesus of Suburbia', length: 548, project_id: 1},
  { title: 'Holiday', length: 232, project_id: 1},
  { title: 'Boulevard of Broken Dreams', length: 262, project_id: 1},
  { title: 'Are We The Waiting', length: 162, project_id: 1},
  { title: 'St. Jimmy', length: 176, project_id: 1},
  { title: 'Give Me Novacaine', length: 205, project_id: 1},
  { title: 'She\'s a Rebel', length: 120, project_id: 1},
  { title: 'Extraordinary Girl', length: 213, project_id: 1},
  { title: 'Letterbomb', length: 245, project_id: 1},
  { title: 'Wake Me Up When September Ends', length: 280, project_id: 1},
  { title: 'Homecoming', length: 558, project_id: 1},
  { title: 'Whatsername', length: 254, project_id: 1 }
])

green_day.setlists << american_idiot
american_idiot.songs << american_idiot_tracklist
