green_day = Project.create({ name: 'Green Day', genre: 'Alternative' })

american_idiot = Setlist.create({ title: 'American Idiot', location: 'Canada', time: '2004-09-20 00:00:00', project_id: 1 })

american_idiot_tracklist = Song.create([
  { title: 'American Idiot', length: 174 },
  { title: 'Jesus of Suburbia', length: 548 },
  { title: 'Holiday', length: 232 },
  { title: 'Boulevard of Broken Dreams', length: 262 },
  { title: 'Are We The Waiting', length: 162 },
  { title: 'St. Jimmy', length: 176 },
  { title: 'Give Me Novacaine', length: 205 },
  { title: 'She\'s a Rebel', length: 120 },
  { title: 'Extraordinary Girl', length: 213 },
  { title: 'Letterbomb', length: 245 },
  { title: 'Wake Me Up When September Ends', length: 280 },
  { title: 'Homecoming', length: 558 },
  { title: 'Whatsername', length: 254 }
])

green_day.setlists << american_idiot
american_idiot.songs << american_idiot_tracklist
