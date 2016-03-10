== Room Temperature: A Slack Channel Sentiment Analysis Tool

[See On Heroku](http://room-temperature.herokuapp.com/dashboard)

Room Temperature allows users to monitor general sentiment in their Slack team's channels. Users can select to view data from the past seven days, or they can choose to view data from a single day in that span. They can also filter that data by a user who has authorized the app, highlighting that specific user's sentiments.

### Demo

![]

### Technical Overview

* Slack Web Api
* Indico Sentiment Analysis Api
* Omniauth-slack gem
* Chartkick gem
* Heroku Scheduler


### Instructions

* Clone the project repo
* Run 'bundle install'
* Start the server with 'rails s'
* Visit 'http://localhost:3000'
