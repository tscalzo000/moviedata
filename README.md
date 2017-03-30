# README

This small application shows the current movies now playing across Greece. A simple Ruby on Rails application with PostgreSQL. Uses TMDB for its API data.

To use: clone repository, run rake db:create and rake db:migrate. Launch the rails server and navigate to localhost:3000. Whenever you wish to update the data, press the refresh button.

This is meant to be a single-person use application for demonstration purposes only. The API calls are so numerous that the API becomes unhappy with repeated calls. Thus, I have built in a loop that will restart the API calls if the API shuts off the user (they have a limit of 40 calls in 10 seconds from the same IP). Once the directors are saved in the database using the first loop of the call, when the loop goes through again, it will create the join tables for the movies rather than calling to the API for the director information again. Thankfully, there are no API call limits beyond the small batch limit. If I was concerned about the API calls, I would've built in a loop to check the movies already in the database versus the ones pulled from the first API call to avoid repeating work. However, it would've added more code that wasn't necessary for the functionality of the app, especially since simplicity was emphasized.

Because the challenge called for all the data to be gathered at once, "The data in the database will be updated each time the process runs," and the API calls are limited, I had to build the loop in. As an application, the way I built the API calls were the easiest to do and without the API call limits, it would work with just one run through without the loop. Unfortunately, the loop makes the application slower and requires more work on the server-side but unavoidable with the API call limits.
